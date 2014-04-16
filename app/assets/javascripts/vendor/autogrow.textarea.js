/*!
 * Autogrow Textarea Plugin Version v2.0
 * http://www.technoreply.com/autogrow-textarea-plugin-version-2-0
 *
 * Copyright 2011, Jevin O. Sewaruth
 *
 * Date: March 13, 2011
 */
jQuery.fn.autoGrow = function(){
  return this.each(function(){
    // Variables
    var colsDefault = this.cols;
    var rowsDefault = this.rows;
    
    //Functions
    var grow = function() {
      if(this.style != undefined) {
        this.style.height = '1px'
        this.style.height = Math.max(this.scrollHeight, 100) + "px"
      }
    }

    // Manipulations
    //this.style.width = "auto";
    this.style.height = "auto";
    this.style.overflow = "hidden";
    //this.style.width = ((characterWidth(this) * this.cols) + 6) + "px";
    this.onkeyup = grow;
    this.onfocus = grow;
    this.onblur = grow;
    grow(this);
  });
};
