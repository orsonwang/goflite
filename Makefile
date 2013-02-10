TOP=.
FLITEDIR=$(TOP)/dep

.phony:  all depflite build test install clean

all: build test

depflite: $(FLITEDIR)/flite $(FLITEDIR)/cmu_us_aup.flitevox

$(FLITEDIR)/flite: $(FLITEDIR)/flite-1.5.6-go.tar.bz2
	cd $(FLITEDIR) && tar xvjf flite-1.5.6-go.tar.bz2 && \
		cd flite && CFLAGS="-DCST_AUDIO_NONE -DCST_NO_SOCKETS" ./configure --with-pic --with-audio=none --with-mmap=none && make

$(FLITEDIR)/flite-1.5.6-go.tar.bz2:
	mkdir -p $(FLITEDIR)
	cd $(FLITEDIR) && wget "http://tts.speech.cs.cmu.edu/aup/distr/flite-1.5.6-go.tar.bz2";

$(FLITEDIR)/cmu_us_aup.flitevox:
	mkdir -p $(FLITEDIR)
	cd $(FLITEDIR) && wget "http://tts.speech.cs.cmu.edu/aup/distr/cmu_us_aup.flitevox";

build: depflite
	go build

test: depflite
	go test

install: depflite
	go install

clean:
	rm -rf $(FLITEDIR)