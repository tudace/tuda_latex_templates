$out_dir='../demo-out/';

ensure_path('TEXINPUTS','../tex/');
ensure_path('BIBINPUTS', $out_dir);
@default_files=("examples/*.tex");

$pdf_mode = 4; #lualatex
$MSWin_back_slash = 0;
$do_cd=1; # run inside example dir

$bibtex_use = 2;


$lualatex = 'lualatex %O %P';

# no images
# define fileversion / filedate
$pre_tex_code='\PassOptionsToPackage{demo}{graphicx}\def\fileversion{0.0}\def\filedate{0000/00/00}';

#push @generated_exts, 'glo', 'gls', 'xmpdata', 'bbl', 'alg', 'acn', 'slnc', 'vrb', 'run.xml';
