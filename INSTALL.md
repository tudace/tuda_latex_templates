# TUDa-CI – Installation Notes.

 Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2019

 tuda-ci 2019/10/26

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

[English version below](#how-to-install-tuda-ci-dev-version-from-the-github-repository)

# Installation der TUDa-CI-Templates aus dem GitHub Repository

Um den Prozess der Weiterverarbeitung zu vereinfachen, wurde ein Script erstellt, dass die Versionsinfos ergänzt. Diese Daten werden jedoch für den Kompilierungsprozess benötigt. Sofern Sie nicht wissen, wie sie mir den folgenden Erläuterungen umgehen, benutzen Sie bitte eines der fertigen Release Bundles.

Grundsätzlich genügt es, nach dem Klonen das Skript `addlicense.sh` auszuführen. Es ergänzt an allen Dateien die Lizenzinformationen. Ohne diese Angabe ist das Bundle derzeit nicht kompiliertbar.

Die übrigen Scripte, *prepare_ctan.sh* und *prepare_tuda.sh* sind nicht wirklich Bestandteil des Codes. Sie werden hier archiviert, jedoch lediglich für die Vorbereitung der Releases genutzt. Für die Anwendung spielen sie keine weitere Bedeutung und ihre Konfiguration ist teilweise auf lokale Systeme abgestimmt.

# How to install TUDa-CI dev-Version from the GitHub Repository

To simplify the release process, we decided to add the version information using a script. This script is [addlicense.sh](https://github.com/tudace/tuda_latex_templates/blob/master/addlicense.sh). It's a bash script and will add the required data. If you don't know how to run this, please use the Released CTAN-zip bundles.

The scripts *prepare_tuda.sh* and *prepare_ctan.sh* are not required. Those are just scripts to prepare the bundles for releases. Users usually should not use them.