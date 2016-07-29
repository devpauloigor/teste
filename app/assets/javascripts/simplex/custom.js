$(document).ready(function(){

  $("#txt_desc").autocomplete({




        source: '/tema/autocomplete.json',
       select: function(a,b){
       	var DadosV = b.item.value.split(',');


       	//----------------------Split Grupo

       	var texto = DadosV[1]
       	var texto2 = DadosV[2]

      // 	alert(DadosV[0]);

      	//var comboGrupo= $('#selGrupo').val(DadosV[1]);
       //	var x = document.getElementById('#selGrupo');

       var textoCombo = texto.split(':');

       //var grupo = "option[text="+textoCombo[1].trim()+"]";
       var grupo = textoCombo[1].trim();
       $('#selGrupo option:contains('+grupo+')').attr("selected",true);
      //var x = document.getElementById("selGrupo");
         var y=$("#selGrupo").val();
     // alert(y);

      document.getElementById('selGrupo').disabled = true; 
      document.getElementById('selSubGrupo').disabled = true; 
   	  //var option = document.createElement("option");
      //option.text = textoCombo[1];
      //x.add(option);
      //x.selectedIndex="1";
    //------------------------Fim split grupo ------------------------------


     var textoCombo2 = texto2.split(':');
      var subgrupo = textoCombo2[1].trim();
      $('#selSubGrupo option:contains('+subgrupo+')').attr("selected",true);



     



   $('#txt_desc').val(DadosV[0]);
     
       document.getElementById('txt_desc').disabled = true;
      
      
 },

        appendTo: $('#dialog')

      
   
 

});




$("#txt_desc1").focusout(function(){
  //alert("Saiu");
  $.get("/questao/valida_questao?descricao="+$("#txt_desc1").val(),function(result){


  });



});

$("#testeresp").on('click',function() {
        //alert($(this).attr('id'));
       var  descricao = $("#txt_desc_resp").val().replace(/[\n\r]/g,"pulo");

         alert(descricao);
    });


 $("#txt_desc").focus(function(){
  //var url = "carregasubgrupo";
    //    $.get(url,function(result){
          //document.getElementById('selSubGrupo').disabled = true; 
          //alert(result);
      //  });

 });


	$("#selGrupo").change(function() {
      document.getElementById('selSubGrupo').disabled = false; 
  		var url = "subgrupo?grupo="+$("#selGrupo").val();
        $.get(url,function(result){
        	//alert(result);
        });

         var url2 = "carregasubgrupo";
        $.get(url,function(result){
          //document.getElementById('selSubGrupo').disabled = true; 
          //alert(result);
        });
        

    });

   $(".input-group.date").datepicker({
        format: 'dd/mm/yyyy',
        language: "pt-BR",
        autoclose: true,
        todayHighlight: true
    });

    $(".datas").datepicker({
        format: 'dd/mm/yyyy',
        language: "pt-BR",
        autoclose: true,
        todayHighlight: true
    });


  $("#btnCancelaConsulta").click(function() {

      $("#txt_desc").val('');
         document.getElementById('txt_desc').disabled = false;
            document.getElementById('selGrupo').disabled = false; 

       document.getElementById('selSubGrupo').disabled = true; 
      var url = "subgrupo?grupo="+$("#selGrupo").val();

      var x = document.getElementById('selGrupo');
      x.selectedIndex= 0;

        $.get(url,function(result){
          //alert(result);
        });
        

    });


/*$("#btConsultar").click(function() {

  var url = '/questoes/consulta_questaonquali'

  if(document.getElementById('chknquali').checked==true)
  {
       //alert("Clicooou");
       url.reload();

  }



 });*/


$("#nquali").click(function() { 

       //alert("Clicooou");
      document.getElementById('squali').checked=false

 });


$("#squali").click(function() {  

 
       //alert("Clicooou");
      document.getElementById('nquali').checked=false


 });

 /* $("#txt_desc").keydown(function(e) {



      if(e.keyCode == 8){

         var x = document.getElementById('selGrupo');
         x.selectedIndex= 0;

      document.getElementById('selGrupo').disabled = false; 
      document.getElementById('selSubGrupo').disabled = false; 
       //alert("apagou");

      }

    });*/



    $(".btquestao").on('click',function() {
        //alert($(this).attr('id'));
        var nome = "t"+$(this).attr('id');
        //alert(nome);
        $("#t"+$(this).attr('id')).toggle();
    });


     $('#cons_questao').click(function(){
        var descricao = $('#cons_tquestao').val();
        $.get("/questoes/consulta_questao?descricao="+descricao,function(result){

        });
    });



});

function selecionar_tudo(){ 
   for (i=0;i<document.f1.elements.length;i++) 
      if(document.f1.elements[i].type == "checkbox")  
         document.f1.elements[i].checked=1 
} 


function verificaStatus(){
for (i=0;i<document.f1.elements.length;i++)
if(document.f1.elements[i].type == "checkbox")
if(document.f1.chrckAll.checked == 1) 
document.f1.elements[i].checked=1
else
document.f1.elements[i].checked=0
}

function marcarTodos(nome){
   for (i=0;i<nome.form.elements.length;i++)
    if(nome.form.elements[i].type == "checkbox")
     nome.form.elements[i].checked=1
}


function NovoQualificar(cont){

 if (document.getElementById('selGrupo').value == 0){

      alert("Selecione um grupo e sub grupo");

 }else{


  var url ='cadnovotema';

  var quali = "";
  var c = 0;
  
  for(var i=0; i< cont; i++){
     

    if($('#chkquali'+i).is(':checked')){
      if(c==0){

           quali += $('#chkquali'+i).val();
           c+=1;

      }
      else{

      quali +="|"+$('#chkquali'+i).val();
      }

    } 

  }
//--------------------- teste split ----------------
var x = document.getElementById('selGrupo');
   var y = document.getElementById('selSubGrupo');

  if(  document.getElementById('txt_desc').disabled == true){

var txt = $('#txt_desc').val();
var DadosV = txt.split(',');
var texto = DadosV[3];
  var idtema = texto.split(':');

   //alert("funfou o if");
  // var tema_id= $('#tema_id').val();
   var tema_id= idtema[1];
   //url += '?tema_id='+tema_id+'&&questao_id='+pergunta;

  
  
   url += '?quali='+quali+'&&tema_id='+tema_id;
  
  
     $.get(url,function(result){


        });
   
    $("#txt_desc").val(" ");
    document.getElementById('txt_desc').disabled = false;

    
     x.selectedIndex= 0;

     
      y.selectedIndex= 0;

      document.getElementById('selGrupo').disabled = false; 

       document.getElementById('selSubGrupo').disabled = true; 


     carregapag()
//----------------fim teste split  
  
  }//fim if
  else{
    
       var txt = $('#txt_desc').val();
      var SubGrupo = $('#selSubGrupo').val();
      CadTemaNovo(SubGrupo,txt,quali);
  }

}//fim do else q valida 

}

 function teste(pergunta){
 	 var descricao= $('#txt_desc').val();
 	 var correta= $('#sel_correta').val(); 	 
 	
     window.alert (descricao +" "+ correta +" "+pergunta);

}


function CadResp(pergunta){

   if(document.getElementById("txt_desc_resp").value  == " ")
    {
       window.alert("Campo descrição está vazio");

    }else{

	var url ='cadresposta';
	 var descricao= encodeURIComponent($('#txt_desc_resp').val());
 	 var correta= $('#sel_correta').val();
 	 url += '?descricao='+descricao+'&&correta='+correta+'&&pergunta_id='+pergunta;

 	  // window.alert(url);

 
	 $.get(url,function(result){


        });
	  var descricao= $('#txt_desc_resp').val("");
	  var correta= $('#sel_correta').val(0);
}
}


function validaquestao(){
  
   var url ='valida_questao';
   var descricao= $('#txt_desc1').val()

   url += '?descricao='+descricao;

    // window.alert(url);
   $.get(url,function(result){




        });
    
}




function CadSubGrupo(grupo){
	var url ='cadsubgrupo';
	 var descricao= $('#txt_desc').val();
 	 url += '?nome='+descricao+'&&grupo_id='+grupo;

 	// window.alert(url);
	 $.get(url,function(result){


        });
	  var descricao= $('#txt_desc').val(" ");

}

function CadTema(SubGrupo){
		 

	var url ='cadtemas';
	var descricao= $('#txt_desc').val();
	 url += '?descricao='+descricao+'&&sub_grupo_id='+SubGrupo;
  
 	//window.alert(url);
	 $.get(url,function(result){


        });
	 
    //$("#subgrupo_id :selected").remove();
}

function CadTema2(SubGrupo,descricao, questao){
     

  var url ='cadtemas';
  //var descricao= $('#txt_desc').val();
   url += '?descricao='+descricao+'&&sub_grupo_id='+SubGrupo+'&&questao_id='+questao;
  
  //window.alert(url);
   $.get(url,function(result){


        });
   
    //$("#subgrupo_id :selected").remove();
}



function CadTemaNovo(SubGrupo,descricao,quali){
     

  var url ='cadtemasnovo';
  //var descricao= $('#txt_desc').val();
   url += '?descricao='+descricao+'&&sub_grupo_id='+SubGrupo+'&&quali='+quali;
  
  //window.alert(url);
   $.get(url,function(result){


        });
   
    //$("#subgrupo_id :selected").remove();
     carregapag()
}



function CadRespSubgrupo(pergunta){

	var url ='cadrespostasubgrupo';

//---------------------------------------------------

  //alert(idtema[1]);

//-----------------------------------------------
 var x = document.getElementById('selGrupo');
   var y = document.getElementById('selSubGrupo');

  if(  document.getElementById('txt_desc').disabled == true){

var txt = $('#txt_desc').val();
var DadosV = txt.split(',');
var texto = DadosV[3];
  var idtema = texto.split(':');

   //alert("funfou o if");
	// var tema_id= $('#tema_id').val();
   var tema_id= idtema[1];
	 //url += '?tema_id='+tema_id+'&&questao_id='+pergunta;
	 url += '?questao_id='+pergunta+'&&tema_id='+tema_id;
  
 	
	 $.get(url,function(result){


        });
	 
    $("#txt_desc").val(" ");
    document.getElementById('txt_desc').disabled = false;

    
     x.selectedIndex= 0;

     
      y.selectedIndex= 0;

      document.getElementById('selGrupo').disabled = false; 

       document.getElementById('selSubGrupo').disabled = true; 



  }else if( x.selectedIndex== 0 ||  y.selectedIndex== 0 ){
    //Codigo para cadastrar um novo tema
   
      alert("Preencha e selecione todos os campos");


 
  }else{
    
       var txt = $('#txt_desc').val();
      var SubGrupo = $('#selSubGrupo').val();
      CadTema2(SubGrupo,txt,pergunta);
  }





}



function CadRegist(){
	 var url ='/cadregistro';
	
	 var nome= $('#txt_nome').val();
	 var email= $('#txt_email').val();
	 var perfil= $('#txt_perfil').val();
	 var password= $('#txt_password').val();
	 var password_confirmation= $('#txt_password_confirmation').val();


	  url += '?nome='+nome+'&&email='+email+'&&perfil='+perfil+'&&password='+password+'&&password_confirmation='+password_confirmation;
  
 	
	 $.get(url,function(result){
           window.alert(url);

        });
	 

}




function carregapag(){
	location.reload();
}

