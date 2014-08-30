function! KamailioDictGrep(sbase, dfiles)
    try
        exe 'vimgrep /^\s*' . a:sbase . '.*/j ' . a:dfiles
    catch /.*/
        echo "no matches"
    endtry
endfunction

function! KamailioComplete(findstart, findbase)
    if a:findstart
        " start position to match till cursor
        " - first non-whitespace column:
        " return match(getline("."),'\S')
        " - last word starting from last whitespace, quote,
        "   comma, equal or plus:
        return match(getline("."),"[^ \t\"',=+][^ \t\"',=+]*$")
    else
        " grep the dictionary files and build list of results:
        let dpath = "~/.vim/plugin/kamailio/kamailio-*.dictionary"
        call KamailioDictGrep( escape(a:findbase, '\\/.*$^~[]'), dpath )
        let lmatch = []
        if(a:findbase == '')
			call add(lmatch, {'word': 'a', 'menu': '-- kamailio completion start'})
		endif
        for matchline in getqflist()
            " trim leading whitespace
            let mtokens = split(matchline.text,'@@')
            if len(mtokens) > 0
				let mword =  matchstr(mtokens[0],'\S.*\S')
				call add(lmatch, {'word': mword, 'menu': get(mtokens, 1, '-- kamailio completion')})
			endif
        endfor
        call setqflist([])
        return lmatch
    endif
endfunction
