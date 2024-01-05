# TUDa-CI – Installation Notes for manual installation (Not recommended! See README.md for more information)

Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2024

tuda-ci v3.36 (2024-01-05)

If you only create demo files, have a look at DEMO.md.

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

[English version below](#how-to-install-tuda-ci-dev-version-from-the-github-repository)

# Installation der TUDa-CI-Templates aus dem GitHub Repository

Fur eine lokale installation existiert ab Version 4.00 ein l3build Script. Dies kann über

```
l3build install
```

Die enthaltenden Dateien für das lokale Benutzerkonto installieren. In diesem Fall werden allerdings keine automatischen Updates ausgeführt. Hierfür sollte eine Installation über CTAN bevorzugt werden.

# How to install TUDa-CI dev-Version from the GitHub Repository

To install TUDa-CI for a single user the bundle contains a l3build script since version 4.00. You can use it to install by running

```
l3build install
```

This will install the package files to your users own TEXMFHOME directory. This cannot be use for automatic updates. In any way you should prefer the installation via CTAN.