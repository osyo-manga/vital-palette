
call vital#of("vital").unload()
let s:Scriptnames = vital#of("vital").import("Palette.Scriptnames")

function! s:test_parse_line()
	let S = s:Scriptnames
	OwlCheck S.parse_line("aaa") == {}
	echo S.parse_line("2: vim74/vimrc_example.vim")
	OwlCheck S.parse_line("2: vim74/vimrc_example.vim") == { "file" : "vim74/vimrc_example.vim" , "SID" : 2 }
	OwlCheck S.parse_line("2: vim74/vimrc_example.vim") != { "file" : "vim74/vimrc_example.vim" , "SID" : "2" }
endfunction

