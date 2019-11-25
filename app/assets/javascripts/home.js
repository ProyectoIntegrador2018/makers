// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready', function () {
  // Container for pills returned from a query
  const $pillBox = $('.queryOptionsContainer');
  // Input box for capacities
  const $queryCap = $("#query-capacidades");
  // Input box for materials
  const $queryMat = $("#query-materials");
  // Container for selected capacity
  const $selectedCap = $(".tagBox#capabilities");
  // Container for selected material
  const $selectedMat = $(".tagBox#materials");

  // Indicates if there is at least one selected pill
  function isPillSelected() {
    return $selectedMat.children().length > 0 || $selectedCap.children().length > 0;
  }

  // Returns the HTML of the selected pill
  function getSelectedPill(type) {
    if (type == "capabilities")
      return $(":first-child", $selectedCap);
    else
      return $(":first-child", $selectedMat)
  }

  // Retuns the HTML to render pills
  function getHTMLForPills(results, type) {
    return results.map(r => {
      return `<div data-id="${r.id}" data-type="${type}" class="pill white">${r.name}</div>`;
    });
  }

  // Creates the pills for the items in results (array)
  function draw(results, type) {
    let pillsHTML = getHTMLForPills(results, type);
    $pillBox.html(pillsHTML);
  }

  // Returns a function that makes a query for the type specified
  // ("capabilities" or "materials")
  const processQueryOnCollection = function(type) {
    return function() {
      // Get the value to query
      const query = $(this).val().trim().toLowerCase();
      // Get the item selected for the other type
      let selectedItem;
      if (type == "capabilities")
        selectedItem = getSelectedPill("materials");
      else
        selectedItem = getSelectedPill("capabilities")
      selectedItem = selectedItem.attr('data-id');
      $.ajax({
        url: "/home/related",
        method: "GET",
        dataType: "json",
        data: {
          query: query,
          selectedItem: selectedItem,
          type: type
        },
        error: function (xhr, status, error) {
          console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
          draw(response.results, type);
        }
      });
    };
  };

  const filterCapabilities = processQueryOnCollection('capabilities').bind($queryCap);
  const filterMaterials = processQueryOnCollection('materials').bind($queryMat);

  // Removes the selected pill in container from the provided list of tags
  function removeSelectedPill(pills, container) {
    return $.grep(pills, function(r) {
      return r.id != $(":first-child", container).attr('data-id');
    });
  }

  // Creates pills for capabilities and materials
  function showBothPills() {
    $.ajax({
      url: "/home/related",
      method: "GET",
      dataType: "json",
      data: {
        // both is used if there are selected pills to use for filtering
        type: isPillSelected ? 'both' : 'all',
        selectedMat: getSelectedPill("materials").attr('data-id'),
        selectedCap: getSelectedPill("capabilities").attr('data-id')
      },
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        // Removes the selected capability if there's one
        capabilities_results = removeSelectedPill(response.capabilities, $selectedCap);
        // Removes the selected material if there's one
        materials_results = removeSelectedPill(response.materials, $selectedMat);
        capabilitiesHTML = getHTMLForPills(capabilities_results, "capabilities");
        materialsHTML = getHTMLForPills(materials_results, "materials");
        $pillBox.html(capabilitiesHTML.concat(materialsHTML));
      }
    });
  }

  // Render all pills when the page first loads
  showBothPills();

  // Event handlers
  $queryCap.on('input', filterCapabilities);
  $queryMat.on('input', filterMaterials);
  $queryCap.on('focus', filterCapabilities);
  $queryMat.on('focus', filterMaterials);
  $pillBox.on('click', '.pill.white', onOptionClick);

  // Removes the clicked pill from the options and puts it in the container of selected pill
  function onOptionClick() {
    let $pill = $(this).remove();
    if ($pill.data('type') == 'capabilities') {
      $selectedTag = $selectedCap;
      $selectedQuery = $queryCap;
      $nonSelectedQuery = $queryMat
    }
    else {
      $selectedTag = $selectedMat;
      $selectedQuery = $queryMat;
      $nonSelectedQuery = $queryCap
    }
    $selectedTag.html($pill);
    $selectedQuery.val('');
    $selectedQuery.hide();
    $pill.on('click', onSelectedOptionClick);
    // If a pill has been selected for materials and capabilities, show all pills again
    if ($selectedMat.children().length > 0 && $selectedCap.children().length > 0) {
      showBothPills();
    } else {
      $nonSelectedQuery.focus();
    }
  }

  // Removes the clicked pill from the container
  function onSelectedOptionClick() {
    $(this).parent().next().show();
    $(this).parent().next().focus();
    let $pill = $(this).remove();
    if (!isPillSelected()) {
      showBothPills();
    }
  }

  function submitForm() {
    const capabilities = getSelectedPill("capabilities").text();
    const materials = getSelectedPill("materials").text();
    $('#capabilities_query').val(capabilities);
    $('#materials_query').val(materials);
    $('.search-form').submit();
  }

  $('.searchBtn').click(function(e) {
    e.preventDefault();
    submitForm();
  });

});
