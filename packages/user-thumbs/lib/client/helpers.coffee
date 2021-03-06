Template.registerHelper 'niceName', (_id,firstName)->
	if _id
		user = Meteor.users.findOne _id

	if user
		if firstName == 'firstName'
			str = user.profile.nomeCompleto
			fName = str.substring(0, str.indexOf(" "))
			fName
		else if user.username
			user.username
		else if typeof user.profile != 'undefined' and user.profile.nomeCompleto
			user.profile.nomeCompleto
		else if user.emails[0].address
			user.emails[0].address
		else
			'A user'

Template.registerHelper 'profileThumbSrc', (_id) ->
	if typeof Meteor.users != 'undefined'
		if Meteor.users.findOne _id
			user = Meteor.users.findOne({_id:_id})
			if typeof user.profile != 'undefined' and typeof user.profile.picture != 'undefined'
				picture = user.profile.picture

				if picture.indexOf('/') > -1
					picture
				else
					if typeof ProfilePictures != 'undefined' && ProfilePictures.findOne user.profile.picture
						picture = ProfilePictures.findOne picture
						picture.url({store: 'thumbs'})
