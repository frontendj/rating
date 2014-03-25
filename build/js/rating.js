(function() {
  window.App = {
    initialize: function() {
      alert('test');
      this.getRating();
      this.highlightRating();
      return $('#clear-rating').click((function(_this) {
        return function() {
          return _this.clearRating();
        };
      })(this));
    },
    highlightRating: function() {
      $(document).on('mouseover', '.b-rating_vote .b-rating__item', function() {
        var parent, value;
        parent = $(this).closest('.b-rating');
        value = $(this).attr('data-value') || $(this).attr('value') || $(this).find('input[type="radio"]').attr('value');
        if (value) {
          return parent.attr("class", parent.attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass('b-rating_state-' + value);
        }
      });
      $(document).on('focus', '.b-rating_vote .b-rating__item', function() {
        return $(this).blur();
      });
      $(document).on('mouseleave', '.b-rating_vote', function() {
        var value;
        value = $(this).attr('data-value');
        if (!value) {
          return $(this).attr("class", $(this).attr("class").replace(/\s*b-rating_state-[1-9]/g, ""));
        } else {
          return $(this).attr("class", $(this).attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass('b-rating_state-' + value);
        }
      });
      return $(document).on('click', '.b-rating_vote .b-rating__item', function() {
        var parent, value;
        parent = $(this).closest('.b-rating');
        value = $(this).attr('data-value') || $(this).attr('value') || $(this).find('input[type="radio"]').attr('value');
        if (value) {
          parent.attr('data-value', value);
          App.setRating(value);
        }
        return false;
      });
    },
    setRating: function(value) {
      this.ratingLocalStorage.score += parseInt(value);
      this.ratingLocalStorage.marks += 1;
      localStorage.setItem('rating', JSON.stringify(this.ratingLocalStorage));
      return this.showRating();
    },
    getRating: function() {
      this.ratingLocalStorage = JSON.parse(localStorage.getItem('rating')) || {};
      if (!this.ratingLocalStorage.score || !this.ratingLocalStorage.marks) {
        this.ratingLocalStorage = {
          score: 0,
          marks: 0
        };
      }
      return this.showRating();
    },
    showRating: function() {
      var averageVote;
      averageVote = (this.ratingLocalStorage.marks > 0 ? this.ratingLocalStorage.score / this.ratingLocalStorage.marks : 0);
      $('.b-rating_results').attr("class", $('.b-rating_results').attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass('b-rating_state-' + Math.ceil(averageVote));
      if (averageVote % 1 > 0) {
        return $('.b-rating_results').addClass('b-rating_state-half');
      } else {
        return $('.b-rating_results').removeClass('b-rating_state-half');
      }
    },
    clearRating: function() {
      this.ratingLocalStorage = {
        score: 0,
        marks: 0
      };
      localStorage.setItem('rating', JSON.stringify(this.ratingLocalStorage));
      return this.showRating();
    }
  };

  $(function() {
    return App.initialize();
  });

}).call(this);
