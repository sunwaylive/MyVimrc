" ============================================================================
" Description: An ack/ag/pt/rg powered code search and view tool.
" Author: Ye Ding <dygvirus@gmail.com>
" Licence: Vim licence
" Version: 1.9.0
" ============================================================================

" List of paragraphs, paragraph is main object which stores parsed query result
let s:resultset = []

" cache contains ALL cacheable result
let s:cache = {}

"""""""""""""""""""""""""""""""""
" Getter
"""""""""""""""""""""""""""""""""
" ResultSet()
"
func! ctrlsf#db#ResultSet() abort
    return s:resultset
endf

" FileResultSetBy()
"
func! ctrlsf#db#FileResultSetBy(resultset) abort
    " List of result files, generated by resultset
    let fileset   = []

    let cur_file = ''
    for par in a:resultset
        if cur_file !=# par.filename
            let cur_file = par.filename
            call add(fileset, {
                \ "filename"   : cur_file,
                \ "paragraphs" : [],
                \ })
        endif
        call add(fileset[-1].paragraphs, par)
    endfo

    return fileset
endf

" FileResultSet()
"
func! ctrlsf#db#FileResultSet() abort
    if has_key(s:cache, 'fileset')
        return s:cache['fileset']
    endif

    let fileset = ctrlsf#db#FileResultSetBy(s:resultset)
    let s:cache['fileset'] = fileset

    return fileset
endf

" MatchList()
"
func! ctrlsf#db#MatchList() abort
    " List of matches, generated by resultset
    let matchlist = []

    if has_key(s:cache, 'matchlist')
        return s:cache['matchlist']
    endif

    for par in s:resultset
        call extend(matchlist, par.matches())
    endfo

    let s:cache['matchlist'] = matchlist
    return matchlist
endf

" MatchListQF()
"
func! ctrlsf#db#MatchListQF() abort
    return ctrlsf#db#MatchList()
endf

" MaxLnum()
"
func! ctrlsf#db#MaxLnum()
    if has_key(s:cache, 'maxlnum')
        return s:cache['maxlnum']
    endif

    let max = 0
    for par in s:resultset
        let mlnum = par.lnum() + par.range() - 1
        let max = mlnum > max ? mlnum : max
    endfo

    let s:cache['maxlnum'] = max
    return max
endf

"""""""""""""""""""""""""""""""""
" Setter
"""""""""""""""""""""""""""""""""
func! ctrlsf#db#SetResultSet(resultset) abort
    call ctrlsf#db#ClearCache()
    let s:resultset = a:resultset
endf

"""""""""""""""""""""""""""""""""
" Parser
"""""""""""""""""""""""""""""""""
" s:DefactorizeLine()
"
" Defactorize result line into [filename, line_number, content].
"
" Expected input is like 'autoload/ctrlsf.vim:182-endif', where '-' serves as
" delimiter.
"
" Note: A subtle difference exists between ack's result and ag's, delimiter
" between path and line number is always ':' in ag, but varies in ack
" depending on whether this line matches.
"
func! s:DefactorizeLine(line, fname_guess) abort
    " filename
    let filename = ''

    if a:fname_guess !=# ''
            \ && stridx(a:line, a:fname_guess) == 0
            \ && match(a:line, '^[-:]\d\+[-:]', strlen(a:fname_guess)) != -1
        let filename = a:fname_guess
    else
        let fname_end = 0
        while fname_end != -1
            let fname_end = match(a:line, '[-:]\d\+[-:]', fname_end + 1)
            let possible_fname = strpart(a:line, 0, fname_end)

            " check possible filename aginst actual file to verify
            if filereadable(possible_fname) && !isdirectory(possible_fname)
                let filename = possible_fname
                break
            endif
        endwh
    endif

    " line number
    let lnum = matchstr(a:line, '\d\+', strlen(filename))

    " content
    let content = strpart(a:line, strlen(filename) + strlen(lnum) + 2)

    call ctrlsf#log#Debug(
                \ "DefactorizeLine: [Factor]: [%s, %s, %s], [Orig]: %s",
                \ filename, lnum, content, a:line)

    return [filename, lnum, content]
endf

" ParseAckprgResult()
"
func! ctrlsf#db#ParseAckprgResult(result) abort
    " reset
    let s:resultset = []
    call ctrlsf#db#ClearCache()

    " in case of mixed text from win-style files and unix-style files, breaks
    " result into lines by both <CR><NL> and <NL>.
    let result_lines = split(a:result, '\v(\r\n)|\n')

    let current_file = ""
    let cur          = 0

    while cur < len(result_lines)
        let buffer = []
        let next_file = ''
        let pre_ln    = -1

        while cur < len(result_lines)
            let line = result_lines[cur]
            let cur += 1

            " don't rely on division line any longer. ignore it.
            if line =~ '^--$' || line =~ '^$'
                continue
            endif

            let [fname, lnum, content] = s:DefactorizeLine(line, current_file)

            if fname !=# current_file
                let next_file = fname
                let cur -= 1
                break
            endif

            if (pre_ln == -1) || (lnum == pre_ln + 1)
                let pre_ln = lnum
                call add(buffer, [fname, lnum, content])
            else
                let cur -= 1
                break
            endif
        endwh

        if len(buffer) > 0
            let paragraph = ctrlsf#class#paragraph#New(buffer)
            call add(s:resultset, paragraph)
        endif

        let current_file = next_file
    endwh
endf

"""""""""""""""""""""""""""""""""
" Cache
"""""""""""""""""""""""""""""""""
" ClearCache
"
func! ctrlsf#db#ClearCache() abort
    let s:cache = {}
endf