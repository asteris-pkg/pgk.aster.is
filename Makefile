DATAS := $(shell find content/aci -name '*.md' | sed 's/content\/aci/data/' | sed 's/.md$$/.json/')

data/%.json: download-releases.sh content/aci/%.md
	./download-releases.sh $* > $@

public: ${DATAS}
	hugo

publish:
	./publish.sh

.PHONY=publish
