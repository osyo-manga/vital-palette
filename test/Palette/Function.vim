
call vital#of("vital").unload()
let s:Function = vital#of("vital").import("Palette.Function")

function! VitalPaletteFunctionTest_plus(a, b)
	return a:a + a:b
endfunction

function! VitalPaletteFunctionTest_args(...)
	return 10
endfunction


function! s:test_parse_line()
	let F = s:Function
	OwlCheck F.parse_line("function VitalPaletteFunctionTest_plus(a, b)") == {
\		"name" : "VitalPaletteFunctionTest_plus",
\		"signature" : ["a", "b"],
\		"call" : function("VitalPaletteFunctionTest_plus")
\	}
	let result = F.parse_line("function VitalPaletteFunctionTest_args(...)")
	OwlCheck result == {
\		"name" : "VitalPaletteFunctionTest_args",
\		"signature" : ["..."],
\		"call" : function("VitalPaletteFunctionTest_args")
\	}
	OwlCheck result.call() == 10
endfunction

