/*9.	Criar uma view de informa��es de material (empresa, descri��o, linha de produto,tipo de material e sub categoria
##### TABELAS ENVOLVIDAS  #####
#                             #   
# MATERIAL                    #   
# TIP_MAT                     #   
# LINHA_PRODUTO               #   
# SUB_CATEGORIA               #   
#                             #   
###############################
 */
 --CRIA��O DA VIEW
 CREATE VIEW V_MATERIAL
 AS
 SELECT A.COD_EMPRESA,A.COD_MAT,A.DESCRICAO,B.COD_TIP_MAT,B.DESC_TIP_MAT,C.COD_LINHA,C.DESC_LINHA,D.COD_CATEGORIA,D.DESC_CATEGORIA
   FROM MATERIAL A
   INNER JOIN TIPO_MAT B
   ON A.COD_EMPRESA=B.COD_EMPRESA
   AND A.COD_TIP_MAT=B.COD_TIP_MAT
   INNER JOIN  LINHA_PRODUTO C
   ON A.COD_EMPRESA=C.COD_EMPRESA
   AND A.COD_LINHA=C.COD_LINHA
   INNER JOIN SUB_CATEGORIA D
   ON A.COD_EMPRESA=D.COD_EMPRESA
   AND A.COD_CATEGORIA=D.COD_CATEGORIA


   --USANDO A VIEW
   SELECT * FROM V_MATERIAL



 
