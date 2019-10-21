// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready', function () {
  // Container for pills returned from a query
  const $pillBox = $('.queryOptionsContainer');
  // Input box for capacities
  const $queryCap = $("#query-capacidades");
  // Input box for materials
  const $queryMat = $("#query-materiales");
  // Container for selected capacity
  const $selectedCap = $(".tagBox#capabilities");
  // Container for selected material
  const $selectedMat = $(".tagBox#materials");

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
        data: {query: query, selectedItem: selectedItem, type: type},
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

  function removeSelectedPill(pills, container) {
    return $.grep(pills, function(r) {
      return r.id != $(":first-child", container).attr('data-id');
    });
  }

  // Creates pills for capabilities and materials
  function showAllPills() {
    $.ajax({
      url: "/home/related",
      method: "GET",
      dataType: "json",
      data: {type : 'all'},
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
  showAllPills();

  // Event handlers
  $queryCap.on('input', filterCapabilities);
  $queryMat.on('input', filterMaterials);
  $queryCap.on('focus', filterCapabilities);
  $queryMat.on('focus', filterMaterials);
  $pillBox.on('click', '.pill.white', onOptionClick);

  function checkCapabilityMaterialRelation(type) {
    $.ajax({
      url: "/home/equipment_relation",
      method: "GET",
      dataType: "json",
      data: {capability: getSelectedPill("capabilities").attr('data-id'), material: getSelectedPill("materials").attr('data-id')},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        if (!response.are_related) {
          if (type == 'capabilities') {
            $selectedMat.empty();
            $queryMat.show();
            $queryMat.focus();
          } else {
            $selectedCap.empty();
            $queryCap.show();
            $queryCap.focus();
          }
        } else {
          showAllPills();
        }
      }
    });
  }

  // Removes the clicked pill from the options and puts it in the container of selected pill
  function onOptionClick() {
    let $pill = $(this).remove();
    if ($pill.data('type') == 'capabilities') {
      $selectedCap.empty();
      $selectedCap.append($pill);
      $queryMat.focus();
      $queryCap.hide();
    }
    else {
      $selectedMat.empty();
      $selectedMat.append($pill);
      $queryCap.focus();
      $queryMat.hide();
    }
    $pill.on('click', onSelectedOptionClick);
    // If a pill has been selected for materials and capabilities, show all pills again
    if ($selectedMat.children().length > 0 && $selectedCap.children().length > 0) {
      checkCapabilityMaterialRelation($pill.data('type'));
    }
  }

  // Removes the clicked pill from the container
  function onSelectedOptionClick() {
    $(this).parent().next().show();
    $(this).parent().next().focus();
    let $pill = $(this).remove();
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
