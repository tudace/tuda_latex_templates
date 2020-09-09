# TUDa-CI – Demo creation process

 Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2020

 tuda-ci 2020/09/09

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

It's possible to build all templates at once using the *latexmkrc* file located in the repo.

After cloning, you simply can run latexmk in the main directory. This will create the files without images. These are disabled using the demo option of the *graphicx* bundle).

With adjusting the `$pre_tex_code' in *latexmkrc* one can change this setting or set custom options for the bundles.