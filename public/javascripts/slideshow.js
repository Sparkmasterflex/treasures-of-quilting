var SlideShow = Class.create({
  initialize: function(options) {
    this.parent = options.parent;
    this.slides = options.slides;
    this.links = options.links || null;
    this.caption = options.caption || null;
    this.seconds = options.seconds;
    this.captions = [];
    this.count = this.slides.length;
    for(var i = 0; i < this.count; i++) {
      this.slides[i].setStyle({display: 'none'});
      this.slides[i].writeAttribute('id', 'slide_' + i);
    }
    if(this.caption || this.links) this.insertControlsDiv();
    this.showFirstSlide();
  },

  insertControlsDiv: function() {
    var side = this.parent.hasClassName('left') ? 'left-' : '';
    this.slideControls = new Element('div', {id: 'controls', 'class': 'dark-grad '+ side + 'bottom-rounded'});
    this.parent.insert({after: this.slideControls})
    if(this.caption) this.insertCaption();

    if(this.links) {
      switch(this.links) {
        case 'next':
          this.createNextPrevLinks();
          break;
        case 'slide':
          this.createSlideLinks();
          break;
      }
    }
  },

  insertCaption: function() {
    var paragraphTag = new Element('p'),
        firstCaption = this.slides[0].down('img').readAttribute('title');
    
    paragraphTag.insert(firstCaption);
    this.slideControls.insert(paragraphTag);
  },

 createNextPrevLinks: function() {
   var btns = new Element('menu', {id: 'slideLinks', "class": 'clearfix'});
   ['previous', 'next'].each(function(link){
     var btn = new Element('a', {id: link, "class": 'next-prev', href: '#' + link}),
         li = new Element('li');
     btn.insert(link);
     li.insert(btn);
     btns.insert(li);
     link == 'next' ?
          btn.observe('click', this.nextSlide.bindAsEventListener(this)) :
            link == 'previous' ?
              btn.observe('click', this.prevSlide.bindAsEventListener(this)) :
                btn.observe('click', this.learnMore.bindAsEventListener(this));
   }.bind(this));
        
    this.slideControls.insert(btns);
  },

  createSlideLinks: function() {
    var i = 0;

    this.ulSlide = new Element('ul', {id: 'slideLinks', "class": 'clearfix'});
    this.slides.each( function(img) {
      var link = new Element('a', {href: '#slide_' + i, 'class': 'icon hidden'}),
          li = new Element('li', {'class': 'slide_' + i});

      link.insert(img.down('img').readAttribute('title'));
      li.insert(link);
      this.ulSlide.insert(li);
      i++;
    }.bind(this));
    this.slideControls.insert(this.ulSlide);
    this.ulSlide.down('li').addClassName('current');
    this.ulSlide.select('li a').invoke('observe', 'click', this.gotoSlide.bindAsEventListener(this));
  },

  showFirstSlide: function() {
    var first = this.slides.first().addClassName('current');
    first.setStyle({display: 'block'});
    if(this.seconds) this.startTimer();
  },

  gotoNextSlide: function() {
    var current = this.parent.down('li.current'),
        slideOn = parseInt(current.identify().gsub('slide_', '')),
        nextOn = slideOn == (this.count - 1) ? 0 : slideOn + 1,
        nextSlide = this.slides[nextOn];

    new Effect.Fade(current, {duration: '.5'});
    new Effect.Appear(nextSlide, {duration: '.5', queue: 'end'});
    current.removeClassName('current');
    nextSlide.addClassName('current');

    if(this.links == 'slide') {
      this.ulSlide.down('li.current').removeClassName('current')
      this.ulSlide.down('li.slide_' + nextOn).addClassName('current');
    }
    if(this.caption) this.changeCaption(nextSlide);
  },

  nextSlide: function(e) {
    e.stop();
    var current = this.parent.down('li.current'),
        slideOn = parseInt(current.identify().gsub('slide_', '')),
        nextOn = slideOn == (this.count - 1) ? 0 : slideOn + 1;
    this.toSlide(current, nextOn);

    if(this.seconds) {
      this.timer.stop();
      this.startDelayTimer();
    }
  },

  prevSlide: function(e) {
    e.stop();
    var current = this.parent.down('li.current'),
        slideOn = parseInt(current.identify().gsub('slide_', '')),
        prevOn = slideOn == 0 ? this.count - 1 : slideOn - 1;
    this.toSlide(current, prevOn);

    if(this.seconds) {
      this.timer.stop();
      this.startDelayTimer();
    }
  },

  learnMore: function(e) {
    e.stop();
    var el = Event.element(e),
        current = this.parent.down('li.current'),
        href = '/projects/' + current.down('input').value;
    window.location = href;
  },

  gotoSlide: function(e) {
    e.stop();
    var el = Event.element(e),
        href = el.readAttribute('href').gsub('#', ''),
        selected = $(href),
        imagesUL = selected.up('ul'),
        current = imagesUL.down('li.current'),
        ul = el.up('ul'),
        newCurrent = 'li.' + href;
    if(selected != current) {
      new Effect.Fade(current, {duration: '.5'});
      new Effect.Appear(selected, {
        duration: '.5',
        queue: 'end'
      });
      current.removeClassName('current');
      selected.addClassName('current');
      ul.down('li.current').removeClassName('current');
      ul.down(newCurrent).addClassName('current');
      if(this.caption) this.changeCaption(selected);
    }
    if(this.seconds) {
      this.timer.stop();
      this.startDelayTimer();
    }
  },

  toSlide: function(current, on) {
    var selected = this.slides[on];

    new Effect.Fade(current, {duration: '.5'});
    new Effect.Appear(selected, {duration: '.5', queue: 'end'});
    current.removeClassName('current');
    selected.addClassName('current');
    if(this.caption) this.changeCaption(selected);
  },

  changeCaption: function(slide) {
    this.slideControls.down('p').update(slide.down('img').readAttribute('title'));
  },

  startTimer: function() {
    if(this.delay) this.delay.stop();
    this.timer = new PeriodicalExecuter(function(e) {
      this.gotoNextSlide();
    }.bind(this), this.seconds);
  },

  stopTimer: function() {
    this.timer.stop();
  },

  startDelayTimer: function() {
    if(this.delay) this.delay.stop();
    this.delay = new PeriodicalExecuter(function(e){
      this.startTimer();
    }.bind(this), (this.seconds/2));
  }
});