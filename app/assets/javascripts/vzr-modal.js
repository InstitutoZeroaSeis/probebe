(function() {
  'use strict'

  function vzrModal(element, openBtn) {
    this._element = element

    this._element.appendChild(this.closeButton())
    this._element.classList.add('vzr-modal')
    this.open(openBtn)
  }

  vzrModal.prototype.closeButton = function() {
    var closeButton = document.createElement('a')
    closeButton.classList.add('vzr-modal-btn-close')
    closeButton.addEventListener('click', this.close.bind(this))
    return closeButton
  }

  vzrModal.prototype.show = function() {
    this._element.classList.add('is-visible')
  }

  vzrModal.prototype.open = function(openBtn) {
    openBtn.addEventListener('click', this.show.bind(this))
  }

  vzrModal.prototype.close = function() {
    this._element.classList.remove('is-visible')
  }

  if (!window.vzr) {
    window.vzr = {}
  }

  window.vzr.modal = function(selector, openBtn) {
    openBtn = typeof openBtn !== 'undefined' ? openBtn : '.open-modal';
    selector = typeof selector !== 'undefined' ? selector : '.vzr-modal';
    return new vzrModal(document.querySelector(selector), document.querySelector(openBtn))
  }

})()
