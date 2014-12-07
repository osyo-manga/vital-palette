
call vital#of("vital").unload()
let s:Highlight = vital#of("vital").import("Palette.Highlight")


function! s:test_parse()
	let Highlight = s:Highlight
	OwlCheck Highlight.parse("SpecialKey     xxx term=bold ctermfg=1 guifg=#303030")
\		== {'ctermfg': '1', 'term': 'bold', 'name ': 'SpecialKey', 'guifg': '#303030'}

	OwlCheck Highlight.parse("Question       xxx links to Cursor")
\		== {'name ': 'Question', 'link': 'Cursor'}

	OwlCheck Highlight.parse("hier_warning   xxx cleared")
\		== {'cleared': 1, 'name ': 'hier_warning'}

	OwlCheck Highlight.parse("Search         xxx term=reverse ctermfg=0 ctermbg=14 guifg=Black guibg=Yellow1")
\		== {'ctermfg': '0', 'ctermbg': '14', 'term': 'reverse', 'name ': 'Search', 'guibg': 'Yellow1', 'guifg': 'Black'}


	OwlCheck Highlight.parse("TabLine        xxx term=underline cterm=underline ctermfg=0 ctermbg=7 gui=underline guifg=#BBBBBB\n                   guibg=#333333 ")
\		== {'ctermfg': '0', 'ctermbg': '7', 'gui': 'underline', 'term': 'underline', 'name ': 'TabLine', 'guibg': '#333333', 'cterm': 'underline', 'guifg': '#BBBBBB'}

endfunction


echo vital#of("vital").import("Palette.Highlight").get("TabLine", 0)


