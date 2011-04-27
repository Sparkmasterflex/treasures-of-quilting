/* Borrowed from http://github.com/alloy/complex-form-examples */

function replace_ids(s){
  var new_id = new Date().getTime();
  return s.replace(/NEW_RECORD/g, new_id);
}

function addNestedItem(e) {
  e.stop();
  var el = Event.element(e),
      parent = $(el.readAttribute('data-update')),  //house_members
      template = eval(el.readAttribute('data-template')),  // new_household_member
      class_name = el.readAttribute('href').replace(/.*#/, '');  //household_member

  parent.down('.no-records') ?
    parent.update(replace_ids(template)) :
    parent.insert({bottom: replace_ids(template)});

  var target = parent.select("." + class_name).last();

  new Effect.Highlight(target, {
    afterFinish: function(effect) {
      effect.element.down('.remove_nested_item').observe('click', removeNestedItem);
      if (class_name == "threshold") {
        effect.element.down('.comparison_type select').observe('change', updateThresholdComparisonValue);
        effect.element.down('.comparable_attribute select').observe('change', updateThresholdComparisonType);
      }
    }
  });
}

function removeNestedItem(e) {
  e.stop();
  var el = Event.element(e),
      class_name = el.readAttribute('href').replace(/.*#/, '.'),
      target = el.up(class_name),
      parent = target.up();

  removeFromDom(target, function() {
    target.remove();

    if (parent.childElements().size() == 0) {
      switch (class_name) {
        case '.threshold':
        case '.household_member':
          var colspan = class_name == '.threshold' ? 4 : 6,
              inner_html = class_name == '.threshold' ? 'No defined thresholds' : 'No household members',
              insert = new Element('tr');

          insert.update(new Element('td', {colspan: colspan, 'class': 'no-records aligncenter'}).update(inner_html));
          break;
        case '.document':
          insert = new Element('li', {'id': 'no_documents', 'class': 'no-records aligncenter'}).update('No documents');
          break;
      }

      parent.update(insert);
    }
  });
}

document.observe('dom:loaded', function() {
  $$('.add_nested_item').invoke('observe', 'click', addNestedItem);
  $$('.remove_nested_item').invoke('observe', 'click', removeNestedItem);
});
