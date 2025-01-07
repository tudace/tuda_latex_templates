@ECHO OFF
CHCP 65001
l3build install --texmfhome $(kpsewhich.exe --var-value TEXMFLOCAL)
mktexlsr
