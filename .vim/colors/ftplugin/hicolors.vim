" hicolors.vim : colorscheme editor
"   ***		This file is intended to go into .vim/ftplugin/
"  Author:	Charles E. Campbell, Jr.
"  Date:	Oct 20, 2004
"  Version:	4
"
"  Explanation of Files:
"     doc/hicolors.txt       help page
"     syntax/hicolors.vim    hicolors.txt syntax highlighting
"     ftplugin/hicolors.vim  provides colorscheme editor
if &cp || exists("s:loaded_ftplugin_hicolors")
 finish
endif
let g:loaded_ftplugin_hicolors= "v4"

" ---------------------------------------------------------------------
"  Public Interface:
augroup AuHiColorTxt
 au!
 au WinEnter hicolors.txt	call <SID>HiColorTxtStart()
 au WinLeave hicolors.txt	silent! unmap <cr>|silent! unmap <leftmouse>|silent! unmap <rightmouse>|silent! unmap <leftdrag>
augroup END

" ---------------------------------------------------------------------
" HiColorTxtStart:
fun! s:HiColorTxtStart()
"  call Dfunc("HiColorTxtStart()")
  nnoremap <silent> <leftmouse>		<leftmouse>:set lz<bar>call <SID>ColorHelp()<bar>set nolz<cr>
  nnoremap <silent> <rightmouse>	<leftmouse>:set lz<bar>call <SID>ChgColor()<bar>set nolz<cr>
  nnoremap <silent> <cr>			:set lz<bar>call <SID>ChgColor()<bar>set nolz<cr>
"  call Dret("HiColorTxtStart")
endfun
"let g:decho_bufenter= 1  "Decho
call s:HiColorTxtStart()


" ---------------------------------------------------------------------
" ChgColor:
fun! s:ChgColor()
"  call Dfunc("ChgColor() cursorword<".expand("<cword>").">")
  augroup AuHiColorTxt
   au!
  augroup END
  let color   = expand("<cword>")
  exe "nnoremap <silent> <leftmouse> <leftmouse>:call <SID>HandleLeftMouse(1,'".color."')<cr>"
  exe "nnoremap <silent> <cr>        :call <SID>HandleLeftMouse(1,'".color."')<cr>"
  exe "nnoremap <silent> <leftdrag>  <leftmouse>:call <SID>HandleLeftMouse(0,'".color."')<cr>"
  let listline = line(".")
  let listcol  = col(".")
  let listwin  = winnr()
  bot 7new
  let chgwin   = winnr()
  exe listwin."wincmd w"
  3
  norm! H
  call cursor(listline,listcol)
  exe chgwin."wincmd w"

  call s:DisplayColorLevel(color)
  set nomod
  " standard starting place for cursor
  2
  norm! 0
"  call Dret("ChgColor")
endfun

" ---------------------------------------------------------------------
" DisplayColorLevel: allows one to change the foreground/background
" and attributes (bold, underline, reverse, inverse, italic, standout)
fun! s:DisplayColorLevel(color)
"  call Dfunc("DisplayColorLevel(color<".a:color.">)")

  " change buffer name to [colorname]
  exe "file [".a:color."]"
  if expand("#") == ""
   exe bufnr("#")."bwipe!"
  endif

  " set up local highlighting
  hi hiNormal gui=NONE cterm=NONE ctermfg=white ctermbg=black guifg=white guibg=black
  exe "syn match hi".a:color.' "'.a:color.'"'
  exe "hi link hi".a:color." ".a:color
  syn match hiDCLred		"Red  \[.*]"	contains=hiBarRed01,hiBarRed
  syn match hiDCLgreen		"Green  \[.*]"	contains=hiBarGreen01,hiBarGreen
  syn match hiDCLblue		"Blue  \[.*]"	contains=hiBarBlue01,hiBarBlue
  syn match hiDCLword		"Foreground\|Background"

  syn match hiBarRed01		'=' contained nextgroup=hiBarRed02,hiBarRed
  syn match hiBarRed02		'=' contained nextgroup=hiBarRed03,hiBarRed
  syn match hiBarRed03		'=' contained nextgroup=hiBarRed04,hiBarRed
  syn match hiBarRed04		'=' contained nextgroup=hiBarRed05,hiBarRed
  syn match hiBarRed05		'=' contained nextgroup=hiBarRed06,hiBarRed
  syn match hiBarRed06		'=' contained nextgroup=hiBarRed07,hiBarRed
  syn match hiBarRed07		'=' contained nextgroup=hiBarRed08,hiBarRed
  syn match hiBarRed08		'=' contained nextgroup=hiBarRed09,hiBarRed
  syn match hiBarRed09		'=' contained nextgroup=hiBarRed10,hiBarRed
  syn match hiBarRed10		'=' contained nextgroup=hiBarRed11,hiBarRed
  syn match hiBarRed11		'=' contained nextgroup=hiBarRed12,hiBarRed
  syn match hiBarRed12		'=' contained nextgroup=hiBarRed13,hiBarRed
  syn match hiBarRed13		'=' contained nextgroup=hiBarRed14,hiBarRed
  syn match hiBarRed14		'=' contained nextgroup=hiBarRed15,hiBarRed
  syn match hiBarRed15		'=' contained nextgroup=hiBarRed16,hiBarRed
  syn match hiBarRed16		'=' contained nextgroup=hiBarRed

  syn match hiBarGreen01	'=' contained nextgroup=hiBarGreen02,hiBarGreen
  syn match hiBarGreen02	'=' contained nextgroup=hiBarGreen03,hiBarGreen
  syn match hiBarGreen03	'=' contained nextgroup=hiBarGreen04,hiBarGreen
  syn match hiBarGreen04	'=' contained nextgroup=hiBarGreen05,hiBarGreen
  syn match hiBarGreen05	'=' contained nextgroup=hiBarGreen06,hiBarGreen
  syn match hiBarGreen06	'=' contained nextgroup=hiBarGreen07,hiBarGreen
  syn match hiBarGreen07	'=' contained nextgroup=hiBarGreen08,hiBarGreen
  syn match hiBarGreen08	'=' contained nextgroup=hiBarGreen09,hiBarGreen
  syn match hiBarGreen09	'=' contained nextgroup=hiBarGreen10,hiBarGreen
  syn match hiBarGreen10	'=' contained nextgroup=hiBarGreen11,hiBarGreen
  syn match hiBarGreen11	'=' contained nextgroup=hiBarGreen12,hiBarGreen
  syn match hiBarGreen12	'=' contained nextgroup=hiBarGreen13,hiBarGreen
  syn match hiBarGreen13	'=' contained nextgroup=hiBarGreen14,hiBarGreen
  syn match hiBarGreen14	'=' contained nextgroup=hiBarGreen15,hiBarGreen
  syn match hiBarGreen15	'=' contained nextgroup=hiBarGreen16,hiBarGreen
  syn match hiBarGreen16	'=' contained nextgroup=hiBarGreen

  syn match hiBarBlue01		'=' contained nextgroup=hiBarBlue02,hiBarBlue
  syn match hiBarBlue02		'=' contained nextgroup=hiBarBlue03,hiBarBlue
  syn match hiBarBlue03		'=' contained nextgroup=hiBarBlue04,hiBarBlue
  syn match hiBarBlue04		'=' contained nextgroup=hiBarBlue05,hiBarBlue
  syn match hiBarBlue05		'=' contained nextgroup=hiBarBlue06,hiBarBlue
  syn match hiBarBlue06		'=' contained nextgroup=hiBarBlue07,hiBarBlue
  syn match hiBarBlue07		'=' contained nextgroup=hiBarBlue08,hiBarBlue
  syn match hiBarBlue08		'=' contained nextgroup=hiBarBlue09,hiBarBlue
  syn match hiBarBlue09		'=' contained nextgroup=hiBarBlue10,hiBarBlue
  syn match hiBarBlue10		'=' contained nextgroup=hiBarBlue11,hiBarBlue
  syn match hiBarBlue11		'=' contained nextgroup=hiBarBlue12,hiBarBlue
  syn match hiBarBlue12		'=' contained nextgroup=hiBarBlue13,hiBarBlue
  syn match hiBarBlue13		'=' contained nextgroup=hiBarBlue14,hiBarBlue
  syn match hiBarBlue14		'=' contained nextgroup=hiBarBlue15,hiBarBlue
  syn match hiBarBlue15		'=' contained nextgroup=hiBarBlue16,hiBarBlue
  syn match hiBarBlue16		'=' contained nextgroup=hiBarBlue

  syn match hiBarRed		":" contained
  syn match hiBarGreen		":" contained
  syn match hiBarBlue		":" contained

  syn match hiDCLfg			"Foregnd\[.*]"
  syn match hiDCLbg			"Backgnd\[.*]"
  syn match hiDCLword		"[-+]\(Bold\|Italic\|Reverse\|Underline\|WriteColorscheme\|Cancel\|Done\)"

  if has("gui_running")
   hi hiBarRed01   gui=NONE guifg=#000000 guibg=NONE
   hi hiBarRed02   gui=NONE guifg=#180000 guibg=NONE
   hi hiBarRed03   gui=NONE guifg=#280000 guibg=NONE
   hi hiBarRed04   gui=NONE guifg=#380000 guibg=NONE
   hi hiBarRed05   gui=NONE guifg=#480000 guibg=NONE
   hi hiBarRed06   gui=NONE guifg=#580000 guibg=NONE
   hi hiBarRed07   gui=NONE guifg=#680000 guibg=NONE
   hi hiBarRed08   gui=NONE guifg=#780000 guibg=NONE
   hi hiBarRed09   gui=NONE guifg=#880000 guibg=NONE
   hi hiBarRed10   gui=NONE guifg=#980000 guibg=NONE
   hi hiBarRed11   gui=NONE guifg=#a80000 guibg=NONE
   hi hiBarRed12   gui=NONE guifg=#b80000 guibg=NONE
   hi hiBarRed13   gui=NONE guifg=#c80000 guibg=NONE
   hi hiBarRed14   gui=NONE guifg=#d80000 guibg=NONE
   hi hiBarRed15   gui=NONE guifg=#e80000 guibg=NONE
   hi hiBarRed16   gui=NONE guifg=#f00000 guibg=NONE

   hi hiBarGreen01 gui=NONE guifg=#000000 guibg=NONE
   hi hiBarGreen02 gui=NONE guifg=#001800 guibg=NONE
   hi hiBarGreen03 gui=NONE guifg=#002800 guibg=NONE
   hi hiBarGreen04 gui=NONE guifg=#003800 guibg=NONE
   hi hiBarGreen05 gui=NONE guifg=#004800 guibg=NONE
   hi hiBarGreen06 gui=NONE guifg=#005800 guibg=NONE
   hi hiBarGreen07 gui=NONE guifg=#006800 guibg=NONE
   hi hiBarGreen08 gui=NONE guifg=#007800 guibg=NONE
   hi hiBarGreen09 gui=NONE guifg=#008800 guibg=NONE
   hi hiBarGreen10 gui=NONE guifg=#009800 guibg=NONE
   hi hiBarGreen11 gui=NONE guifg=#00a800 guibg=NONE
   hi hiBarGreen12 gui=NONE guifg=#00b800 guibg=NONE
   hi hiBarGreen13 gui=NONE guifg=#00c800 guibg=NONE
   hi hiBarGreen14 gui=NONE guifg=#00d800 guibg=NONE
   hi hiBarGreen15 gui=NONE guifg=#00e800 guibg=NONE
   hi hiBarGreen16 gui=NONE guifg=#00f000 guibg=NONE

   hi hiBarBlue01  gui=NONE guifg=#000000 guibg=NONE
   hi hiBarBlue02  gui=NONE guifg=#000018 guibg=NONE
   hi hiBarBlue03  gui=NONE guifg=#000028 guibg=NONE
   hi hiBarBlue04  gui=NONE guifg=#000038 guibg=NONE
   hi hiBarBlue05  gui=NONE guifg=#000048 guibg=NONE
   hi hiBarBlue06  gui=NONE guifg=#000058 guibg=NONE
   hi hiBarBlue07  gui=NONE guifg=#000068 guibg=NONE
   hi hiBarBlue08  gui=NONE guifg=#000078 guibg=NONE
   hi hiBarBlue09  gui=NONE guifg=#000088 guibg=NONE
   hi hiBarBlue10  gui=NONE guifg=#000098 guibg=NONE
   hi hiBarBlue11  gui=NONE guifg=#0000a8 guibg=NONE
   hi hiBarBlue12  gui=NONE guifg=#0000b8 guibg=NONE
   hi hiBarBlue13  gui=NONE guifg=#0000c8 guibg=NONE
   hi hiBarBlue14  gui=NONE guifg=#0000d8 guibg=NONE
   hi hiBarBlue15  gui=NONE guifg=#0000e8 guibg=NONE
   hi hiBarBlue16  gui=NONE guifg=#0000f0 guibg=NONE
  else
   hi hiBarRed01   cterm=NONE ctermfg=1  ctermbg=NONE
   hi hiBarRed02   cterm=NONE ctermfg=2  ctermbg=NONE
   hi hiBarRed03   cterm=NONE ctermfg=3  ctermbg=NONE
   hi hiBarRed04   cterm=NONE ctermfg=4  ctermbg=NONE
   hi hiBarRed05   cterm=NONE ctermfg=5  ctermbg=NONE
   hi hiBarRed06   cterm=NONE ctermfg=6  ctermbg=NONE
   hi hiBarRed07   cterm=NONE ctermfg=7  ctermbg=NONE
   hi hiBarRed08   cterm=NONE ctermfg=8  ctermbg=NONE
   hi hiBarRed09   cterm=NONE ctermfg=9  ctermbg=NONE
   hi hiBarRed10   cterm=NONE ctermfg=10 ctermbg=NONE
   hi hiBarRed11   cterm=NONE ctermfg=11 ctermbg=NONE
   hi hiBarRed12   cterm=NONE ctermfg=12 ctermbg=NONE
   hi hiBarRed13   cterm=NONE ctermfg=13 ctermbg=NONE
   hi hiBarRed14   cterm=NONE ctermfg=14 ctermbg=NONE
   hi hiBarRed15   cterm=NONE ctermfg=15 ctermbg=NONE
   hi hiBarRed16   cterm=NONE ctermfg=16 ctermbg=NONE

   hi hiBarGreen01 cterm=NONE ctermfg=1  ctermbg=NONE
   hi hiBarGreen02 cterm=NONE ctermfg=2  ctermbg=NONE
   hi hiBarGreen03 cterm=NONE ctermfg=3  ctermbg=NONE
   hi hiBarGreen04 cterm=NONE ctermfg=4  ctermbg=NONE
   hi hiBarGreen05 cterm=NONE ctermfg=5  ctermbg=NONE
   hi hiBarGreen06 cterm=NONE ctermfg=6  ctermbg=NONE
   hi hiBarGreen07 cterm=NONE ctermfg=7  ctermbg=NONE
   hi hiBarGreen08 cterm=NONE ctermfg=8  ctermbg=NONE
   hi hiBarGreen09 cterm=NONE ctermfg=9  ctermbg=NONE
   hi hiBarGreen10 cterm=NONE ctermfg=10 ctermbg=NONE
   hi hiBarGreen11 cterm=NONE ctermfg=11 ctermbg=NONE
   hi hiBarGreen12 cterm=NONE ctermfg=12 ctermbg=NONE
   hi hiBarGreen13 cterm=NONE ctermfg=13 ctermbg=NONE
   hi hiBarGreen14 cterm=NONE ctermfg=14 ctermbg=NONE
   hi hiBarGreen15 cterm=NONE ctermfg=15 ctermbg=NONE
   hi hiBarGreen16 cterm=NONE ctermfg=16 ctermbg=NONE

   hi hiBarBlue01  cterm=NONE ctermfg=1  ctermbg=NONE
   hi hiBarBlue02  cterm=NONE ctermfg=2  ctermbg=NONE
   hi hiBarBlue03  cterm=NONE ctermfg=3  ctermbg=NONE
   hi hiBarBlue04  cterm=NONE ctermfg=4  ctermbg=NONE
   hi hiBarBlue05  cterm=NONE ctermfg=5  ctermbg=NONE
   hi hiBarBlue06  cterm=NONE ctermfg=6  ctermbg=NONE
   hi hiBarBlue07  cterm=NONE ctermfg=7  ctermbg=NONE
   hi hiBarBlue08  cterm=NONE ctermfg=8  ctermbg=NONE
   hi hiBarBlue09  cterm=NONE ctermfg=9  ctermbg=NONE
   hi hiBarBlue10  cterm=NONE ctermfg=10 ctermbg=NONE
   hi hiBarBlue11  cterm=NONE ctermfg=11 ctermbg=NONE
   hi hiBarBlue12  cterm=NONE ctermfg=12 ctermbg=NONE
   hi hiBarBlue13  cterm=NONE ctermfg=13 ctermbg=NONE
   hi hiBarBlue14  cterm=NONE ctermfg=14 ctermbg=NONE
   hi hiBarBlue15  cterm=NONE ctermfg=15 ctermbg=NONE
   hi hiBarBlue16  cterm=NONE ctermfg=16 ctermbg=NONE
  endif

  hi hiBarRed   ctermfg=red   ctermbg=black guifg=red   guibg=black
  hi hiBarGreen ctermfg=green ctermbg=black guifg=green guibg=black
  hi hiBarBlue  ctermfg=blue  ctermbg=black guifg=blue  guibg=black

  hi link hiDCLred		hiNormal
  hi link hiDCLgreen	hiNormal
  hi link hiDCLblue 	hiNormal
  hi link hiDCLfg		hiNormal
  hi link hiDCLbg		hiNormal
  hi link hiDCLword		hiNormal

  exe "put ='".a:color."'"
  1d
  redraw!

  " get current selected highlighting name's color and attributes
  let s:colorname   = a:color
  let colorid       = synIDtrans(synID(1,1,1))
  let s:fg          = synIDattr(colorid,"fg#")
  let s:bg          = synIDattr(colorid,"bg#")
  let s:isbold      = synIDattr(colorid,"bold")
  let s:isital      = synIDattr(colorid,"italic")
  let s:isrvrs      = synIDattr(colorid,"reverse")
  let s:isundr      = synIDattr(colorid,"underline")
  let s:keep_isbold = s:isbold
  let s:keep_isital = s:isital
  let s:keep_isrvrs = s:isrvrs
  let s:keep_isundr = s:isundr
"  call Decho("keeping attributes: bold=".s:isbold." ital=".s:isital." rvrs=".s:isrvrs." undr=".s:isundr)
"  call Decho("colorid=".colorid."  fg=".s:fg."  bg=".s:bg)

  if has("gui_running")
   let s:rfg    = substitute(s:fg,'^.\(..\)....','\1','')
   let s:rbg    = substitute(s:bg,'^.\(..\)....','\1','')
   let s:gfg    = substitute(s:fg,'^...\(..\)..','\1','')
   let s:gbg    = substitute(s:bg,'^...\(..\)..','\1','')
   let s:bfg    = substitute(s:fg,'^.....\(..\)','\1','')
   let s:bbg    = substitute(s:bg,'^.....\(..\)','\1','')
   if s:fg == ""
   	let s:rfg= "00"
   	let s:gfg= "00"
   	let s:bfg= "00"
   endif
   if s:bg == ""
   	let s:rbg= "00"
   	let s:gbg= "00"
   	let s:bbg= "00"
   endif
   if !exists("s:keep_rfg")
"   	call Decho("keeping current colors: fg=".s:rfg.s:gfg.s:bfg." bg=".s:rbg.s:gbg.s:bbg)
    let s:keep_rfg    = s:rfg
    let s:keep_gfg    = s:gfg
    let s:keep_bfg    = s:bfg
    let s:keep_rbg    = s:rbg
    let s:keep_gbg    = s:gbg
    let s:keep_bbg    = s:bbg
   endif
   let subtitle = "         Foreground          Background          ".(s:isbold? "+" : "-")."Bold"
   let redbar   = "    Red  [".s:ColorBar(1,s:rfg)."]  [".s:ColorBar(1,s:rbg)."]  ".(s:isital? "+" : "-")."Italic"
   let greenbar = "  Green  [".s:ColorBar(1,s:gfg)."]  [".s:ColorBar(1,s:gbg)."]  ".(s:isrvrs? "+" : "-")."Reverse"
   let bluebar  = "   Blue  [".s:ColorBar(1,s:bfg)."]  [".s:ColorBar(1,s:bbg)."]  ".(s:isundr? "+" : "-")."Underline"
   exe "put ='".subtitle."'"
   exe "put ='".redbar."'"
   exe "put ='".greenbar."'"
   exe "put ='".bluebar."'"
   put =''
   put ='         WriteColorscheme  Cancel  Done'
   set nomod
  else
   if !exists("s:keep_fg")
"   	call Decho("keeping current colors: fg=".s:fg."bg=".s:bg)
    let s:keep_fg    = s:fg + 1
    let s:keep_bg    = s:bg + 1
   endif
   let boldline = "                             ".(s:isbold? "+" : "-")."Bold"
   let fgbar    = "  Foregnd[".s:ColorBar(0,s:fg)."]  ".(s:isital? "+" : "-")."Italic"
   let bgbar    = "  Backgnd[".s:ColorBar(0,s:bg)."]  ".(s:isrvrs? "+" : "-")."Reverse"
   let undrline = "                             ".(s:isundr? "+" : "-")."Underline"
   exe "put ='".boldline."'"
   exe "put ='".fgbar."'"
   exe "put ='".bgbar."'"
   exe "put ='".undrline."'"
   put =''
   put ='         WriteColorscheme  Cancel  Done'
   set nomod
  endif
"  call Dret("DisplayColorLevel")
endfun

" ---------------------------------------------------------------------
" HandleLeftMouse:
fun! s:HandleLeftMouse(set_keepline,color)
"  call Dfunc("HandleLeftMouse(set_keepline=".a:set_keepline." color<".a:color.">)")

  let curword = expand("<cWORD>")
  let curline = line(".")
  if a:set_keepline
   let s:keepline = curline
   call s:GetColorSpecs(a:color)
  else
   let curline= s:keepline
   exe s:keepline
  endif
  let curcol  = col(".")
"  call Decho("curword<".curword."> curline=".curline." curcol=".curcol)

  if     curword == "WriteColorscheme" && a:set_keepline
   call s:WriteColorscheme()
  elseif curword == "Cancel" && a:set_keepline
   call s:Cancel()
  elseif curword == "Done" && a:set_keepline
   call s:Done()
  elseif curword == "+Bold" && a:set_keepline
   let s:isbold= 0
   norm! $F+r-
   call s:SetColor()
  elseif curword == "-Bold" && a:set_keepline
   let s:isbold= 1
   norm! $F-r+
   call s:SetColor()
  elseif curword == "+Italic" && a:set_keepline
   let s:isital= 0
   norm! $F+r-
   call s:SetColor()
  elseif curword == "-Italic" && a:set_keepline
   let s:isital= 1
   norm! $F-r+
   call s:SetColor()
  elseif curword == "+Reverse" && a:set_keepline
   let s:isrvrs= 0
   norm! $F+r-
   call s:SetColor()
  elseif curword == "-Reverse" && a:set_keepline
   let s:isrvrs= 1
   norm! $F-r+
   call s:SetColor()
  elseif curword == "+Underline" && a:set_keepline
   let s:isundr= 0
   norm! $F+r-
   call s:SetColor()
  elseif curword == "-Underline" && a:set_keepline
   let s:isundr= 1
   norm! $F-r+
   call s:SetColor()

  elseif has("gui_running") &&
   	 \ (3 <= curline && curline <= 5) &&
   	 \ ((10 < curcol && curcol < 27) || (30 < curcol && curcol < 47))
   " Gui colorbar
   norm! F[ldt]
   let leftcol= col(".")
   exe "norm i".s:ColorBar(0,curcol - leftcol)."\<esc>0"
   set nomod
   call s:SetColor()

  elseif (3 <= curline && curline <= 4) && (10 < curcol && curcol < 27)
   " console colorbar
   norm! F[ldt]
   let leftcol= col(".")
   exe "norm i".s:ColorBar(0,curcol - leftcol)."\<esc>0"
   set nomod
   call s:SetColor()
  endif
  set nomod
"  call Dret("HandleLeftMouse")
endfun

" ---------------------------------------------------------------------
" ColorBar:
fun! s:ColorBar(ishex,intensity)
"  call Dfunc("ColorBar(ishex=".a:ishex." intensity=".a:intensity.")")
  let intensity= 0

  " convert intensity (string/hex) to a number
  if a:ishex
   let n         =  substitute(a:intensity,'\u','\l&','ge')
   let intensity =  0
   let hex2n_0   =  0
   let hex2n_1   =  1
   let hex2n_2   =  2
   let hex2n_3   =  3
   let hex2n_4   =  4
   let hex2n_5   =  5
   let hex2n_6   =  6
   let hex2n_7   =  7
   let hex2n_8   =  8
   let hex2n_9   =  9
   let hex2n_a   = 10
   let hex2n_b   = 11
   let hex2n_c   = 12
   let hex2n_d   = 13
   let hex2n_e   = 14
   let hex2n_f   = 15
   while n != ""
    let r         = hex2n_{strpart(n,0,1)}
    let n         = strpart(n,1)
    let intensity = 16*intensity + r
   endwhile
   let intensity= intensity/16
  else
   let intensity= a:intensity
  endif

  " construct bar given requested intensity/color
  " intensity is 0..15
  let i   = 0
  let bar = ""
  while i < intensity
   let bar = bar."="
   let i   = i + 1
  endwhile
  let i   = i + 1
  let bar = bar.":"
  while i < 16
   let bar = bar." "
   let i   = i + 1
  endwhile

  " map current line,column,intensity to (red/green/blue) foreground/background
  let curline = line(".")
  let curcol  = col(".")
  if has("gui_running")

   " convert 0..15 intensity to 0..255 intensity for gui
   let intensity = 16*intensity + 8
   if intensity >= 240
    let intensity= 255
   elseif intensity <= 8
    let intensity= 0
   endif
"   call Decho("ishex conversion: intensity=".intensity)

   if     curline == 3
   	" red
    if     10 < curcol && curcol < 27
    	let s:rfg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." rfg=".s:rfg)
    elseif 30 < curcol && curcol < 47
    	let s:rbg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." rbg=".s:rbg)
    endif

   elseif curline == 4
   	" green
    if     10 < curcol && curcol < 27
    	let s:gfg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." gfg=".s:gfg)
    elseif 30 < curcol && curcol < 47
    	let s:gbg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." gbg=".s:gbg)
    endif

   elseif curline == 5
   	" blue
    if     10 < curcol && curcol < 27
    	let s:bfg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." bfg=".s:bfg)
    elseif 30 < curcol && curcol < 47
    	let s:bbg= s:Nr2Hex(intensity)
"        call Decho("intensity=".intensity." curline=".curline." curcol=".curcol." bbg=".s:bbg)
    endif
   endif

  else
   " console vim
   let curline   = line(".")
   let curcol    = col(".")
   if     curline == 3
   	let s:fg= intensity - 1
   elseif curline == 4
   	let s:bg= intensity - 1
   endif
"   call Decho("fg=".s:fg." bg=".s:bg)
  endif

"  call Dret("ColorBar bar<".bar.">")
  return bar
endfun

" ---------------------------------------------------------------------
" SetColor: sets highlighting color
"   Uses s:colorname
"   red   : rfg rbg
"   green : gfg gbg
"   blue  : bfg bbg
fun! s:SetColor()
"  call Dfunc("s:SetColor()")
"  call Decho("guispec  <".s:guispec.">")
"  call Decho("ctermspec<".s:ctermspec.">")

  let attrib=""
  if s:isbold|let attrib=attrib.",bold"|endif
  if s:isital|let attrib=attrib.",italic"|endif
  if s:isrvrs|let attrib=attrib.",reverse"|endif
  if s:isundr|let attrib=attrib.",underline"|endif

  if has("gui_running")
   " handle gui
"   call Decho("fg colors : red=".s:rfg." green=".s:gfg." blue=".s:bfg)
"   call Decho("bg colors : red=".s:rbg." green=".s:gbg." blue=".s:bbg)
"   call Decho("attributes: bold=".s:isbold." ital=".s:isital." rvrs=".s:isrvrs." undr=".s:isundr)
   let guifg= s:rfg.s:gfg.s:bfg
   let guibg= s:rbg.s:gbg.s:bbg
   let hicmd= "hi ".s:colorname." ".s:ctermspec." gui=NONE".attrib." guifg=#".guifg." guibg=#".guibg
"   call Decho(hicmd)
   exe hicmd

  else
   " handle cterm
"   call Decho("fg#".s:fg." bg#".s:bg)
   if s:fg <= 0
   	if s:bg <= 0
	 let hicmd= "hi ".s:colorname." cterm=NONE".attrib." ctermfg=NONE ctermbg=NONE"." ".s:guispec
	else
     let hicmd= "hi ".s:colorname." cterm=NONE".attrib." ctermfg=NONE"." ctermbg=".s:bg." ".s:guispec
	endif
   elseif s:bg <= 0
    let hicmd="hi ".s:colorname." cterm=NONE".attrib." ctermfg=".s:fg." ctermbg=NONE ".s:guispec
   else
    let hicmd= "hi ".s:colorname." cterm=NONE".attrib." ctermfg=".s:fg." ctermbg=".s:bg." ".s:guispec
   endif
"   call Decho(hicmd)
   exe hicmd

  endif
"  call Dret("s:SetColor")
endfun

" ---------------------------------------------------------------------
" Nr2Hex: The function Nr2Hex() returns the Hex string of a number.
fun! s:Nr2Hex(nr)
"  call Dfunc("Nr2Hex(nr=".a:nr.")")
  let n = a:nr
  let r = ""
  while n
   let r = '0123456789ABCDEF'[n % 16] . r
   let n = n / 16
  endwhile
  if a:nr < 16
   let r= "0".r
  endif
  if a:nr == 0
   let r= "00"
  endif
"  call Dret("Nr2Hex ".r)
  return r
endfun

" ---------------------------------------------------------------------
" WriteColorscheme: modified version of Travis Hume's Mkcolorscheme
fun! s:WriteColorscheme()
"  call Dfunc("WriteColorscheme()")

  " grab current highlight definitions
  silent! redir @"
   silent hi
  redir END

  " create a new scratch buffer
  1new
  set buftype=nofile bufhidden=hide noswapfile ft=vim

  " put highlighting output into scratch buffer
  silent put! "

  " cleanup: delete empty lines, remove links, join lines as needed
  silent! g/^$\| links /d
  silent! v/\<xxx\>/-1j
  silent! %s/ xxx / /
  silent! %s/^/hi /
  silent! g/\<hiBar\(Red\|Green\|Blue\)\>/d

  " get new colorscheme name
  let newschemename= substitute(input("Enter new colorscheme name: "),'\.vim$','','e')

  if newschemename != ""
   " append some stuff at the beginning to set the value of background
   " and clear the current highlighting.
   if expand("$USER") != ""
    call append( 0,'" '.newschemename.'.vim: a new colorscheme by '.expand("$USER"))
   else
    call append( 0,'" '.newschemename.'.vim: a new colorscheme')
   endif
   call append( 1,'" Written By: Charles E. Campbell, Jr.'."'".'s ftplugin/hicolors.vim')
   call append( 2,'" Date: '.strftime("%c"))
   call append( 3,"")
   call append( 4,'" ---------------------------------------------------------------------')
   call append( 5,'" Standard Initialization:')
   call append( 6,"set bg=".&bg)
   call append( 7,"hi clear")
   call append( 8,"if exists( \"syntax_on\")" )
   call append( 9," syntax reset")
   call append(10,"endif")
   call append(11,"let g:colors_name=\"".escape(newschemename,' ')."\"" )
   call append(12,"")
   call append(13,'" ---------------------------------------------------------------------')
   call append(14,'" Highlighting Commands:')
   silent! %s/\^\[//g
   exe "silent wq ".newschemename.".vim"
   call s:Done()
  endif
"  call Dret("WriteColorscheme")
endfun

" ---------------------------------------------------------------------
" Cancel:
fun! s:Cancel()
"  call Dfunc("Cancel()")
  let s:isbold = s:keep_isbold
  let s:isital = s:keep_isital
  let s:isrvrs = s:keep_isrvrs
  let s:isundr = s:keep_isundr
"  call Decho("restore attributes: bold=".s:isbold." ital=".s:isital." rvrs=".s:isrvrs." undr=".s:isundr)

  if has("gui_running")
   " gui
   let s:rfg    = s:keep_rfg
   let s:gfg    = s:keep_gfg
   let s:bfg    = s:keep_bfg
   let s:rbg    = s:keep_rbg
   let s:gbg    = s:keep_gbg
   let s:bbg    = s:keep_bbg
"   call Decho("restore fg colors : red=".s:rfg." green=".s:gfg." blue=".s:bfg)
"   call Decho("restore bg colors : red=".s:rbg." green=".s:gbg." blue=".s:bbg)
   call cursor(3,11)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_rfg)."\<esc>"
   call cursor(3,31)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_rbg)."\<esc>"
   call cursor(4,11)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_gfg)."\<esc>"
   call cursor(4,31)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_gbg)."\<esc>"
   call cursor(5,11)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_bfg)."\<esc>"
   call cursor(5,31)
   norm! F[ldt]
   exe "norm i".s:ColorBar(1,s:keep_bbg)."\<esc>"
 
   " ColorBar() does some rounding for display purposes
   " Thus the colors need to be restored accurately again
   " prior to SetColor()
   let s:rfg    = s:keep_rfg
   let s:gfg    = s:keep_gfg
   let s:bfg    = s:keep_bfg
   let s:rbg    = s:keep_rbg
   let s:gbg    = s:keep_gbg
   let s:bbg    = s:keep_bbg
  else
   " console
   let s:fg= s:keep_fg
   let s:bg= s:keep_bg
"   call Decho("restore fg#".s:fg." bg#".s:bg)
   call cursor(3,11)
   norm! F[ldt]
   exe "norm i".s:ColorBar(0,s:keep_fg)."\<esc>"
   call cursor(4,11)
   norm! F[ldt]
   exe "norm i".s:ColorBar(0,s:keep_bg)."\<esc>"
  endif

  call s:SetColor()
  call s:Done()

"  call Dret("Cancel")
endfun

" ---------------------------------------------------------------------
" Done:
fun! s:Done()
"  call Dfunc("Done()")
  set nomod
  nnoremap <leftmouse> <leftmouse>:call <SID>ChgColor()<cr>
  nnoremap <silent> <cr>		  :set lz<bar>call <SID>ChgColor()<bar>set nolz<cr>
  unmap <leftdrag>
  if has("gui_running")
   unlet s:keep_rfg
   unlet s:keep_bfg
   unlet s:keep_gfg
   unlet s:keep_rbg
   unlet s:keep_bbg
   unlet s:keep_gbg
  else
   unlet s:keep_fg
   unlet s:keep_bg
  endif
  close!
"  call Dret("Done")
endfun

" ---------------------------------------------------------------------
" GuiColorSpecs: get color specs for gui=... and cterm=... .
"   If gui_running, then cterm specs are used to keep console specifications
"   in the colorscheme.
"   Otherwise, then gui specs are used to keep gui specifications in
"   colorscheme.
fun! s:GetColorSpecs(color)
"  call Dfunc("GetColorSpecs()")
  let keep_regA  = @a
  redir @a
   exe "silent hi ".a:color
  redir END
  let colorspec  = substitute(@a,'\n\s*',' ','ge')
  let s:ctermspec= substitute(colorspec,'^.\{-}\(cterm.\{-}\)\s*gui.*$','\1','e')
  let s:guispec  = substitute(colorspec,'^.\{-}\(gui.*\)$','\1','e')
  if s:ctermspec !~ "cterm"|let s:ctermspec= ""|endif
  if s:guispec   !~ "gui"  |let s:guispec  = ""|endif
  let s:ctermspec = "term=NONE start=NONE stop=NONE ".s:ctermspec
  let s:guispec   = "term=NONE start=NONE stop=NONE ".s:guispec
  let @a= keep_regA
"  call Decho("ctermspec<".s:ctermspec.">")
"  call Decho("guispec  <".s:guispec.">")
"  call Dret("GetColorSpecs")
endfun

" ---------------------------------------------------------------------
" s:ColorHelp: brings up a help entry (if one's present) on the given
" colorname
fun! s:ColorHelp()
"  call Dfunc("ColorHelp()")
  let color   = expand("<cword>")
  echo " "
  let v:errmsg= ""
  exe "silent! help hl-".color
  if v:errmsg != ""
    he group-name
	if search('^\s\+\*\='.color,'W') != 0
	 exe "norm! z\<cr>"
	else
     echomsg "no help available for <".color.">"
	endif
  endif
"  call Dret("ColorHelp")
endfun

" ---------------------------------------------------------------------
" vim: ts=4
