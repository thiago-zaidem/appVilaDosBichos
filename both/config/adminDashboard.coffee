AdminDashboard.addSidebarItem "Configurações",
  icon: 'gear'
  urls: [
    {
      title: "Perfis de acesso"
      url: AdminDashboard.path("/PerfisAcesso")
      collection: "PerfisAcesso"
    }
    {
      title: "Planos de saúde"
      url: AdminDashboard.path("/PlanosSaude")
      collection: "PlanosSaude"
    }
    {
      title: "Tipo de provedor"
      url: AdminDashboard.path("/ProvidersType")
      collection: "ProvidersType"
    }
    {
      title: "Tipo de serviços"
      url: AdminDashboard.path("/ProvidersService")
      collection: "ProvidersService"
    }
  ]
AdminDashboard.addSidebarItem "Meus dados",
  icon:'file-text-o'
  urls: [
    {
      title: "Cadastrais"
      url: AdminDashboard.path("/Providers")
      collection: "Providers"
    }
	  {
		  title: "Pets"
		  url: AdminDashboard.path("/Pets")
		  collection: "Pets"
	  }
    {
      title: "Locais de atendimento"
      url: AdminDashboard.path("/ServiceLocation")
      collection: "ServiceLocation"
    }
  ]
AdminDashboard.addSidebarItem "Relatórios",
  icon:'pie-chart'
  urls: [
    {
      title: "Histórico de buscas"
      url: AdminDashboard.path("/ProvidersHistorySearch")
      collection: "ProvidersHistorySearch"
    }
  ]
AdminDashboard.addSidebarItem "Site",
  icon: "desktop"
  urls: [
    {
      title: "Quem somos"
      url: AdminDashboard.path("/QuemSomos")
      collection: "QuemSomos"
    }
    {
      title: "Equipe"
      url: AdminDashboard.path("/Equipe")
      collection: "Equipe"
    }
    {
      title: "Serviços"
      url: AdminDashboard.path("/Slideshow")
      collection: "Slideshow"
    }
    {
      title: "Quem somos"
      url: AdminDashboard.path("/QuemSomos")
      collection: "QuemSomos"
    }
    {
      title: "Equipe"
      url: AdminDashboard.path("/Equipe")
      collection: "Equipe"
    }
    {
      title: "Serviços"
      url: AdminDashboard.path("/Slideshow")
      collection: "Slideshow"
    }
  ]