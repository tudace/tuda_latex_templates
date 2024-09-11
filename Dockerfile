FROM archlinux:latest AS build
WORKDIR /logo
# Dependencies
RUN pacman -Sy --needed --noconfirm inkscape librsvg
# Build logo
RUN curl -O https://www.tu-darmstadt.de/media/medien_stabsstelle_km/services/medien_cd/das_bild_der_tu_darmstadt.pdf \
	&& inkscape das_bild_der_tu_darmstadt.pdf --export-filename=p1_i.svg --export-dpi=300 --pages=1 \
	&& sed -i 's/icc-color([^)]*)//g' p1_i.svg \
	&& sed -i 's/#000000/#1d1d1bff/g' p1_i.svg \
	&& rsvg-convert -f pdf -o tuda_logo.pdf p1_i.svg --export-id=g23 \
	&& rm das_bild_der_tu_darmstadt.pdf p1_i.svg

FROM registry.gitlab.com/islandoftex/images/texlive:latest AS run
# Dependencies
RUN apt-get update && apt-get install -y librsvg2-bin nodejs imagemagick ghostscript inkscape
RUN sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"SVG\"/rights=\"read|write\" pattern=\"SVG\"/" /etc/ImageMagick-6/policy.xml
# Install logo
COPY --from=build /logo/tuda_logo.pdf .
RUN mkdir -p "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
	&& mv tuda_logo.pdf "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
	&& texhash --verbose
# cancel the build if logo is not found
RUN kpsewhich tuda_logo.pdf
# Install tudace
WORKDIR /tudace
COPY . .
RUN l3build install --full --texmfhome="$(kpsewhich -var-value=TEXMFDIST)"
RUN texhash --verbose
WORKDIR /
