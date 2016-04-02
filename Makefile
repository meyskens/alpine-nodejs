TARGET ?= amd64
VERSION ?= 4.4.2
NPM_VERSION ?= 2
ARCHS ?= amd64 armhf
BASE_ARCH ?= amd64


build: tmp-$(TARGET)/Dockerfile
	docker build --no-cache --build-arg VERSION=$(VERSION) --build-arg NPM_VERSION=v$(NPM_VERSION)  -t meyskens/alpine-nodejs:$(TARGET)-$(VERSION) tmp-$(TARGET)


tmp-$(TARGET)/Dockerfile: Dockerfile
	rm -rf tmp-$(TARGET)
	mkdir tmp-$(TARGET)
	cp Dockerfile $@
	for arch in $(ARCHS); do                     \
	  if [ "$$arch" != "$(TARGET)" ]; then       \
	    sed -i "/arch=$$arch/d" $@;              \
	  fi;                                        \
	done
	sed -i '/#[[:space:]]*arch=$(TARGET)/s/^#//' $@
	sed -i 's/#[[:space:]]*arch=$(TARGET)//g' $@
	cat $@
