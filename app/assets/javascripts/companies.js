
$(function(){

    var opts = {
      lines: 13, // The number of lines to draw
      length: 20, // The length of each line
      width: 10, // The line thickness
      radius: 30, // The radius of the inner circle
      corners: 1, // Corner roundness (0..1)
      rotate: 0, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      color: '#000', // #rgb or #rrggbb or array of colors
      speed: 1, // Rounds per second
      trail: 60, // Afterglow percentage
      shadow: false, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: '50%', // Top position relative to parent
      left: '50%' // Left position relative to parent
  };
  var target = document.getElementById('spinner');


  $( ".datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "yy-mm-dd",
    });


  if($(".editing").length > 0){
     $('.data_refresh').on('click', function(e){
        e.preventDefault();
        var spinner = new Spinner(opts).spin(target);

        $.getJSON('/companies.json', {url: $("#company_duedil_co_url").val()}, function(company_data){
           $("#company_name").val(company_data.name);
            $("#company_duedil_locale").val(company_data.locale);
            $("#company_reg_co_num").val(company_data.reg_co_num);
            $("#company_description").val(company_data.description);
            $('#company_reg_address1').val(company_data.reg_address1);
            $('#company_reg_address2').val(company_data.reg_address2);
            $('#company_reg_address3').val(company_data.reg_address3);
            $('#company_reg_address4').val(company_data.reg_address4);
            $('#company_reg_address_postcode').val(company_data.reg_address_postcode);
            $('#company_phone').val(company_data.phone);
            $('#company_email').val(company_data.email);
            $('#company_website').val(company_data.website);
            $('#company_currency').val(company_data.currency);
            $("#company_employee_count").val(company_data.employee_count);
            $("#company_incorporation_date").val(company_data.incorporation_date);
            $("#company_turnover").val(company_data.turnover);
            $("#company_shareholders_funds").val(company_data.shareholders_funds);
            spinner.spin(false);
        });
      })
  }else{
    $("#company_name").autocomplete({
      source: function(request, response){
        var term = request.term;

        $.getJSON('/companies.json', {search_term: term}, function(search_results){
          response(search_results);
        })
      },
      focus: function( event, ui ) {
        $("#company_name").val(ui.item.value.name);
        return false;
      },

      select: function(event, ui){
        $("#company_description").val('');
        $('#company_reg_address1').val('');
        $('#company_reg_address2').val('');
        $('#company_reg_address3').val('');
        $('#company_reg_address4').val('');
        $('#company_reg_address_postcode').val('');
        $('#company_phone').val('');
        $('#company_email').val('');
        $('#company_website').val('');
        $('#company_currency').val('');
        $("#company_employee_count").val('');
        $("#company_incorporation_date").val('');
        $("#company_turnover").val('');
        $("#company_shareholders_funds").val('');
        var spinner = new Spinner(opts).spin(target);
        $("#company_name").val(ui.item.value.name);
        $("#company_duedil_co_url").val(ui.item.value.company_url);
        $("#company_duedil_locale").val(ui.item.value.locale);
        $("#company_reg_co_num").val(ui.item.value.id);


        $.getJSON('/companies.json', {url: ui.item.value.company_url, check_existing: true}, function(company_data){

          if (company_data.existing_record){
            spinner.spin(false);
            alert("You have already onboarded ths company");
            $("#company_name").val('');
            $("#company_duedil_co_url").val('');
            $("#company_duedil_locale").val('');
            $("#company_reg_co_num").val('');
          }else{

            $("#company_description").val(company_data.description);
            $('#company_reg_address1').val(company_data.reg_address1);
            $('#company_reg_address2').val(company_data.reg_address2);
            $('#company_reg_address3').val(company_data.reg_address3);
            $('#company_reg_address4').val(company_data.reg_address4);
            $('#company_reg_address_postcode').val(company_data.reg_address_postcode);
            $('#company_phone').val(company_data.phone);
            $('#company_email').val(company_data.email);
            $('#company_website').val(company_data.website);
            $('#company_currency').val(company_data.currency);
            $("#company_employee_count").val(company_data.employee_count);
            $("#company_incorporation_date").val(company_data.incorporation_date);
            $("#company_turnover").val(company_data.turnover);
            $("#company_shareholders_funds").val(company_data.shareholders_funds);
            spinner.spin(false);
          }
        });

        return false;
      }
    })
  }



});