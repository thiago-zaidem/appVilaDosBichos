@AdminConfig =
  name: 'Portal Saude'
  skin: 'blue'
  logoutRedirect: 'homeRoute'
  dashboard:
    adminVersion: 'Versão 2.0.1'
    adminLogo: '/img/admin-logo.png'
    adminUrl: 'admin'
  collections:
    Providers:
      label: "Prestador"
      color: 'red'
      panel: true
      tableColumns: [
        {label: 'Nome', name:'nome'}
        {label: 'Perfil', name:'perfilTipo'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
      joinCollection: ['providersType', 'planosSaude']
    ProvidersType:
      label: "Tipo de prestador"
      tableColumns: [
        {label: 'Tipo', name:'tipo'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    ProvidersService:
      label: "Tipo de serviço"
      tableColumns: [
        {label: 'Nome', name:'nome'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    ServiceLocation:
      label: "Local de atendimento"
      tableColumns: [
        {label: 'Nome', name:'nome'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    Pets:
      label: "Pets"
      color: 'red'
      panel: true
      tableColumns: [
	      {label: 'Nome', name:'nome'}
	      {label: 'Especie', name:'especie'}
	      {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    QuemSomos:
      color: 'blue'
      widget: false
      tableColumns: [
        {label: 'Quem Somos', name: 'quemSomos'}
        {label: 'Missão', name: 'missao'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    PerfisAcesso:
      label: "Perfis de acesso"
      color: 'blue'
      widget: false
      tableColumns: [
        {label: 'Nome', name: 'nome'}
        {label: 'Menu', name: 'menu'}
        {label: 'Ações', name: 'acoes'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    PlanosSaude:
      label: "Planos de saúde"
      color: 'blue'
      widget: false
      tableColumns: [
        {label: 'Nome', name: 'nome'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
    ProvidersHistorySearch:
      label: "Histórico de buscas"
      color: 'blue'
      widget: false
      tableColumns: [
        {label: 'Ip', name: 'ipAddr'}
        {label: 'userId', name: 'userId'}
        {label: 'Data do cadastro', name: 'auditoria.createdAt'}
      ]
  autoForm:
    omitFields: ['usuario','auditoria']