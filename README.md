# Painel de Suporte Técnico

Ferramenta em batch (`.bat`) que reúne, em um único menu, os comandos e rotinas mais usados no dia a dia de suporte técnico em ambientes Windows — limpeza de sistema, diagnóstico de rede, verificação de antivírus, backup de logs, entre outros.

Criado por **Felipe Wehmuth**.

## ✨ Funcionalidades

| # | Opção |
|---|-------|
| 1 | Limpeza de arquivos temporários |
| 2 | Limpeza de disco (cleanmgr) |
| 3 | Verificação de arquivos do sistema (SFC) |
| 4 | Reparo da imagem do Windows (DISM) |
| 5 | Reset do Windows Update |
| 6 | Reset de configurações de rede |
| 7 | Atualização das políticas de grupo (GPO) |
| 8 | Limpeza de logs de eventos |
| 9 | Informações do sistema (msinfo32) |
| 10 | Gerenciador de dispositivos |
| 11 | Ver adaptadores de rede |
| 12 | Ver e atualizar programas instalados via winget |
| 13 | Ver processos em execução |
| 14 | Ver status dos principais serviços |
| 15 | Executar CHKDSK no disco C: |
| 16 | Abrir PowerShell |
| 17 | Verificar ipconfig |
| 18 | Testar velocidade da internet |
| 19 | Verificar espaço em disco |
| 20 | Verificar status do antivírus |
| 21 | Testar conectividade com o Google |
| 22 | Backup dos logs de eventos |
| 23 | Visualizar dispositivos USB conectados |
| 24 | Ver uso de memória e CPU |
| 25 | Baixar arquivo via HTTPS |
| 26 | Gerar relatório de políticas de grupo (gpresult) |
| 27 | Otimizador de Memória (Swap/RAM) — submenu dedicado |
| U |  GitHub | Felipe Wehmuth

Cada opção mostra antes de rodar: o que o comando faz, tempo estimado e se afeta arquivos pessoais do usuário — para evitar execuções acidentais.

### 🧠 Otimizador de Memória (opção 27)

A opção **27** abre um submenu dedicado, com ferramentas para liberar memória RAM sem precisar sair do painel principal:

| # | Ação |
|---|------|
| 1 | Exibir uso de memória (total / livre / usada) |
| 2 | Fechar processos pesados (Chrome, Edge, Firefox, Opera, Discord, Spotify, Teams, Steam, OneDrive) |
| 3 | Limpar arquivos temporários |
| 4 | Esvaziar Lixeira |
| 6 | Reiniciar o Windows Explorer |
| 7 | Otimização Completa (executa as opções 2 a 6 em sequência) |
| 0 | Voltar ao menu principal |

## ✅ Requisitos

- Windows 10 ou 11
- Executar **como Administrador** (o script verifica isso automaticamente e recusa rodar sem privilégio elevado)
- PowerShell disponível no PATH (já vem por padrão no Windows)
- Conexão com a internet para as opções de atualização, teste de velocidade e download de arquivos

## 🚀 Como usar

1. Baixe o arquivo `.bat` deste repositório.
2. Escolha uma opção no menu numérico.

## ⚙️ Configuração

No topo do script existem variáveis fáceis de editar antes de usar em outro ambiente:

```bat
set "VERSAO=1.3.0"

```

## ⚠️ Avisos importantes

- Algumas opções são **destrutivas ou exigem reinicialização** (CHKDSK, reset de rede, reset do Windows Update). O script pede uma confirmação extra (S/N) antes de rodar essas.
- Um arquivo `painel_log.txt` é criado na mesma pasta do script para registrar as ações executadas.

## 🛠️ Tecnologias

- Batch script (`cmd.exe`)
- PowerShell / CIM (`Get-CimInstance`) para consultas de sistema mais modernas e compatíveis com versões recentes do Windows

## 📄 Licença

Este projeto está sob a licença MIT — veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🤝 Contribuindo

Sugestões e melhorias são bem-vindas via *issues* ou *pull requests*.
