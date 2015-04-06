scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Capture     = s:V.import("Palette.Capture")
	let s:Scriptnames = s:V.import("Palette.Scriptnames")
endfunction


function! s:_vital_depends()
	return [
\		"Palette.Capture",
\		"Palette.Scriptnames",
\	]
endfunction


function! s:capture(...)
	if get(a:, 1, "") == ""
		return s:Capture.command("function")
	endif
	return s:Capture.command("function /" . a:1)
endfunction


function! s:parse_line(src)
	let parsep = '^function \(.\{-\}\)(\(.*\))$'
	if a:src !~ parsep
		return {}
	endif
	let parsed = matchlist(a:src, parsep)
	let name = substitute(parsed[1], "<SNR>", "\\<SNR>", "")
	return {
\		"name" : name,
\		"signature" : map(split(parsed[2], ","), "substitute(v:val, ' ', '', 'g')"),
\		"call" : function(name),
\	}
endfunction


function! s:parse(src)
	return map(split(a:src, "\n"), "s:parse_line(v:val)")
endfunction


function! s:get(...)
	return s:parse(call("s:capture", a:000))
endfunction


function! s:get_by_SID(sid)
	return s:get("\<SNR>" . a:sid . '_')
endfunction


function! s:get_by_scriptfile(file)
	let result = s:Scriptnames.find("file =~# " . string(a:file))
	PP result
	if empty(result)
		return {}
	endif
	return s:get_by_SID(result.SID)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
