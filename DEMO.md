# TUDa-CI – Demo creation process

Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2024

tuda-ci v3.36 (2024-01-05)

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

It's possible to build all templates at once using the l3build system. After cloning you can run

```
l3build doc
```

within the main directory to build the demo and documentation files. The output can be found in `./build/doc`

Alternatively, you simply can run latexmk in the main directory. This will create the files without images. These are disabled using the demo option of the *graphicx* bundle).

With adjusting the `$pre_tex_code' in *latexmkrc* one can change this setting or set custom options for the bundles.
