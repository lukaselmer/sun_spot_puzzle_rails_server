// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe("dom:loaded", function() {
    // the element in which we will observe all clicks and capture
    // ones originating from pagination links
    var container = $(document.body)

    if (container) {
        var img = new Image;
        img.src = '/images/spinner.gif';

        function createSpinner() {
            var img_el = new Element('img', {
                src: img.src,
                'class': 'spinner'
            });
            var div_el = new Element('div', {
                'class':'spinner-div'
            });
            div_el.appendChild(img_el);
            return div_el;
        }

        container.observe('click', function(e) {
            var el = e.element();
            if (el.match('.pagination a')) {
                var pag_div = el.up('.pagination')
                pag_div.insertBefore(createSpinner(), pag_div.firstChild);
                new Ajax.Request(el.href, {
                    method: 'get'
                });
                e.stop();
            }
        })
    }
});