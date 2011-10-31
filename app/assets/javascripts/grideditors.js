
(function($) {

   var SlickEditor = {


      TextCellEditor : function(args) {
         var $input, $wrapper;
         var defaultValue;
         var scope = this;

         this.init = function() {
            $wrapper = $("<div style='z-index:10000;position:absolute;' />")
               .appendTo($("body"));
            $input = $("<input type=text class='editor-text' style='width:100%;height:100%' />")
               .appendTo($wrapper)
               .bind("keydown.nav", function(e) {
                  if (e.keyCode === $.ui.keyCode.LEFT || e.keyCode === $.ui.keyCode.RIGHT) {
                     e.stopImmediatePropagation();
                  } /*else if (e.which == $.ui.keyCode.ESCAPE) {
                     e.preventDefault();
                     scope.cancel();
                  }
                  else if (e.which == $.ui.keyCode.TAB && e.shiftKey) {
                     e.preventDefault();
                     grid.navigatePrev();
                  }
                  else if (e.which == $.ui.keyCode.TAB) {
                     e.preventDefault();
                     grid.navigateNext();
                  } */
               });
            scope.position(args.position);
            $input.focus().select();
            // throw(args);
         };

         this.destroy = function() {
            $input.remove();
         };

         this.focus = function() {
            $input.focus();
         };

         this.position = function(position) {
            $wrapper
               .css("top", position.top - 5)
               .css("left", position.left)
               .css("height", position.height - 5)
               .css("width", position.width - 5);
         };

         this.getValue = function() {
            return $input.val();
         };

         this.setValue = function(val) {
            $input.val(val);
         };

         this.loadValue = function(item) {
            defaultValue = getValueOnItem(args.column.field, item) || "";
            $input.val(defaultValue);
            $input[0].defaultValue = defaultValue;
            $input.select();
         };

         function getValueOnItem(field, item) {
             if (item.get) {
                 return item.get(field);
             } else {
                 return item[field];
             }
         }

         this.serializeValue = function() {
            return $input.val();
         };

         this.applyValue = function(item,state) {
            // item[args.column.field] = state;
            if (item.set) {
               var obj = {};
               obj[args.column.field] = state;
               item.set(obj);
            } else {
               item[args.column.field] = state;
            }
         };

         this.isValueChanged = function() {
            return (!($input.val() == "" && defaultValue == null)) && ($input.val() != defaultValue);
         };

         this.validate = function() {
            if (args.column.validator) {
               var validationResults = args.column.validator($input.val());
               if (!validationResults.valid)
                  return validationResults;
            }

            return {
               valid: true,
               msg: null
            };
         };

         this.init();
      },

      NumericRangeFormatter : function(row, cell, value, columnDef, dataContext) {
         return dataContext.from + " - " + dataContext.to;
      },

      NumericRangeEditor : function(args) {
         var $from, $to;
         var scope = this;

         this.init = function() {
            $from = $("<INPUT type=text style='width:40px' />")
                     .appendTo(args.container)
                     .bind("keydown", scope.handleKeyDown);

            $(args.container).append("&nbsp; to &nbsp;");

            $to = $("<INPUT type=text style='width:40px' />")
                     .appendTo(args.container)
                     .bind("keydown", scope.handleKeyDown);

            scope.focus();
         };

         this.handleKeyDown = function(e) {
            if (e.keyCode == $.ui.keyCode.LEFT || e.keyCode == $.ui.keyCode.RIGHT || e.keyCode == $.ui.keyCode.TAB) {
                  e.stopImmediatePropagation();
            }
         };

         this.destroy = function() {
            $(args.container).empty();
         };

         this.focus = function() {
            $from.focus();
         };

         this.serializeValue = function() {
            return {from:parseInt($from.val(),10), to:parseInt($to.val(),10)};
         };

         this.applyValue = function(item,state) {
            item.from = state.from;
            item.to = state.to;
         };

         this.loadValue = function(item) {
            $from.val(item.from);
            $to.val(item.to);
         };

         this.isValueChanged = function() {
            return args.item.from != parseInt($from.val(),10) || args.item.to != parseInt($from.val(),10);
         };

         this.validate = function() {
            if (isNaN(parseInt($from.val(),10)) || isNaN(parseInt($to.val(),10)))
               return {valid: false, msg: "Please type in valid numbers."};

            if (parseInt($from.val(),10) > parseInt($to.val(),10))
               return {valid: false, msg: "'from' cannot be greater than 'to'"};

            return {valid: true, msg: null};
         };

         this.init();
      },


      /*
       * An example of a "detached" editor.
       * The UI is added onto document BODY and .position(), .show() and .hide() are implemented.
       * KeyDown events are also handled to provide handling for Tab, Shift-Tab, Esc and Ctrl-Enter.
       */
      LongTextCellEditor : function (args) {
         var $input, $wrapper;
         var defaultValue;
         var scope = this;

         this.init = function() {
            var $container = $("body");

            $wrapper = $("<DIV style='z-index:10000;position:absolute;background:white;padding:5px;border:3px solid gray; -moz-border-radius:10px; border-radius:10px;'/>")
               .appendTo($container);

            $input = $("<TEXTAREA hidefocus rows=5 style='backround:white;width:250px;height:80px;border:0;outline:0'>")
               .appendTo($wrapper);

            $("<DIV style='text-align:right'><BUTTON>Save</BUTTON><BUTTON>Cancel</BUTTON></DIV>")
               .appendTo($wrapper);

            $wrapper.find("button:first").bind("click", this.save);
            $wrapper.find("button:last").bind("click", this.cancel);
            $input.bind("keydown", this.handleKeyDown);

            scope.position(args.position);
            $input.focus().select();
         };

         this.handleKeyDown = function(e) {
            if (e.which == $.ui.keyCode.ENTER && e.ctrlKey) {
               scope.save();
            }
            else if (e.which == $.ui.keyCode.ESCAPE) {
               e.preventDefault();
               scope.cancel();
            }
            else if (e.which == $.ui.keyCode.TAB && e.shiftKey) {
               e.preventDefault();
               grid.navigatePrev();
            }
            else if (e.which == $.ui.keyCode.TAB) {
               e.preventDefault();
               grid.navigateNext();
            }
         };

         this.save = function() {
            args.commitChanges();
         };

         this.cancel = function() {
            $input.val(defaultValue);
            args.cancelChanges();
         };

         this.hide = function() {
            $wrapper.hide();
         };

         this.show = function() {
            $wrapper.show();
         };

         this.position = function(position) {
            $wrapper
               .css("top", position.top - 5)
               .css("left", position.left - 5)
         };

         this.destroy = function() {
            $wrapper.remove();
         };

         this.focus = function() {
            $input.focus();
         };

         this.loadValue = function(item) {
            $input.val(defaultValue = item[args.column.field]);
            $input.select();
         };

         this.serializeValue = function() {
            return $input.val();
         };

         this.applyValue = function(item,state) {
            item[args.column.field] = state;
         };

         this.isValueChanged = function() {
            return (!($input.val() == "" && defaultValue == null)) && ($input.val() != defaultValue);
         };

         this.validate = function() {
            return {
               valid: true,
               msg: null
            };
         };

         this.init();
      }

   };

   $.extend(window, SlickEditor);

})(jQuery);
