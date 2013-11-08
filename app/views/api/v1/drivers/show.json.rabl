object @user
extends('api/v1/users/user_base', locals: {hide_email:true})
child(:driver) { extends('api/v1/drivers/driver') }
