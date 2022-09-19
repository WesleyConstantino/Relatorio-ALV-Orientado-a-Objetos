REPORT zhr_report_poo38.

"tabela transparente zhr001_38
DATA: v_table TYPE TABLE OF zhr001_38,
      zhr001_38 TYPE zhr001_38,
      cl_table TYPE REF TO cl_salv_table. "classe do próprio SAP que já gera um relatório altomáticamente

START-OF-SELECTION.
  PERFORM f_get_dados.
  PERFORM f_display_alv.

FORM f_get_dados.
  SELECT *
    FROM zhr001_38
    INTO TABLE v_table.
ENDFORM.

FORM f_display_alv.
  CALL METHOD cl_salv_table=>factory "chama o método factory da classe cl_salv_table
   IMPORTING 
     r_salv_table = cl_table "importa uma tabela pronta alv
   CHANGING 
     t_table = v_table. "Passando nossa tabela interna para o objeto montado
  PERFORM f_feed_functions.
  CALL METHOD cl_table=>display. "chama o método display     
ENDFORM.

"esse form traz diversas funcionalidades em tela para o usuário como: sub total, filtro, exportação para o execel e etc
"tudo isso fica disponível no front-end em forma de botões
FORM f_feed_functions.
  DATA: lc_functions TYPE REF TO cl_salv_functions. "variável local do tipo classes de funções alv
  
  lc_functions = cl_table=>get_functions(). "passando a tabela interna para a variável local e fazendo-a receber uma função
  lc_functions=>set_all( abap_true ). "habilitando todas as funcionalidades do alv com o método set_all()
ENDFORM.
