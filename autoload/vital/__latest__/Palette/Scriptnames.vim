scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:vname = expand("<sfile>:h:h:t")

function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Capture  = s:V.import("Palette.Capture")
endfunction


function! s:_vital_depends()
	return [
\		"Palette.Capture",
\	]
endfunction


function! s:capture()
	return s:Capture.command("scriptnames")
endfunction


function! s:_to_slash_path(path)
	return substitute(a:path, '\\', '/', 'g')
endfunction


function! s:parse_line(src)
	let parsep = '\s*\(\d*\)\s*:\s*\(.*\)'
	if a:src !~ parsep
		return {}
	endif
	let result = matchlist(a:src, parsep)
	return {
\		"SID"  : str2nr(result[1]),
\		"file" : s:_to_slash_path(result[2]),
\	}
endfunction


function! s:parse(scriptnames)
	return map(split(a:scriptnames, "\n"), "s:parse_line(v:val)")
endfunction


let s:get_cache = []
function! s:get()
	if s:get_cache == []
		let s:get_cache = s:parse(s:capture())
	endif
	return copy(s:get_cache)
" 	return s:parse(s:capture())
endfunction


execute "augroup" "vital-palette-scriptnames-" . s:vname
	autocmd!
	autocmd SourcePre * let s:get_cache = []
augroup END


function! s:select(expr, ...)
	call extend(l:, get(a:, 1, {}))
	let __scripts = s:get()
	let __result = []
	for _ in __scripts
		let [file, SID] = values(_)
		if eval(a:expr)
			let __result += [_]
		endif
	endfor
	return __result
endfunction


function! s:find(expr, ...)
	call extend(l:, get(a:, 1, {}))
	let __scripts = s:get()
	for _ in __scripts
		let [file, SID] = values(_)
		if eval(a:expr)
			return { "SID" : SID, "file" : file }
		endif
	endfor
	return {}
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
