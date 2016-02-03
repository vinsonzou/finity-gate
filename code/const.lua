return
{
  SECRET_TOKEN = '123456',
  SECRET_SID = '654321',

  EXPIRE_TOKEN = 1209600, -- 14 days
  EXPIRE_SID = 86400, -- 1 day

  KEY_SID = 'sid/', -- current sid, pattern: sid/{SID}, expired in 1 day
  KEY_TOKEN = 'token/', -- refresh token, pattern: token/{token}, expired in 14 days
  KEY_USER = 'user/', -- user hash
}
