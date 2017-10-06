@DashboardConfig =
	name: 'Portal Saude'
	skin: 'blue'
	logoutRedirect: 'homeRoute'
	dashboard:
		version: 'Versão 2.0.1'
		logo: '/img/admin-logo.png'
		url: 'painel'
	collections:
		Providers:
			meteorCollection: 'providers'
			label: "Serviços"
			color: 'red'
			panel: true
			icon: 'event'
			columnCount: 'servico'
			subColumnCount: 'service'
			tableColumns: [
				{label: 'Nome', name:'nome'}
				{label: 'Serviço', name:'servico'}
				{label: 'Data do cadastro', name: 'auditoria.createdAt'}
			]
		Pets:
			meteorCollection: 'pets'
			label: "Meus pets"
			color: 'red'
			panel: true
			icon: 'event'
			columnCount: 'nome'
			tableColumns: [
				{label: 'Nome', name:'nome'}
				{label: 'Espécie', name:'especie'}
				{label: 'Raça', name:'raca'}
				{label: 'Data do cadastro', name: 'auditoria.createdAt'}
			]