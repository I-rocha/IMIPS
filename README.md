# IMIPS
Processador baseado em MIPS aplicado em FPGA. A arquitetura do processador segue a figura abaixo

![image 0.8](https://user-images.githubusercontent.com/38757175/203063042-2f9c7b2f-e330-48f0-8f7e-3cc8a4b29d7b.png)  
<sup>*Imagem retirada da documentação</sup>


Os arquivos db, incremental_db, output_files, IMIPS.qpf, IMIPS.qsf, IMIPS.sdc, IMIPS.srf, IMIPS_descritopn.txt, cre_ie_info.json são arquivos de sistema do quartus

Arquivos de simulção
Arquivo *.vwf pertencem a arquivos de simulação do formato de onda. Podem não rodar devido ao diretório ser específico do ambiente de desenvolvimento de cada máquina. Pode ser consertado alterando o diretório nos metadados de cada arquivo.

### Main  
As demais pastas contém os módulos principais em Verilog (*.v). O arquivo interfaceGeral.v contém o código principal de integração dos módulos

### Documents  
`/doc/IMIPS.pdf` - é o documento principal descrevendo todo projeto.  
`/doc/sysml/Processor.vpp` - é um arquivo contendo uma modelagem superficial do sistema em sysml. Foi desenvolvido 1 diagrama de requisitos, 4 diagramas de casos de uso, 3 diagramas de atividades  
`/doc/sysml/Processor.pdf` - pequena descrição sobre a modelagem em sysml
