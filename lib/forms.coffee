class Form
    @format:
        struct:(content)->
            "<div class='line'>#{content}</div>"
        text: (name, value='')->
            "<input type='text' name='#{name}' value='#{value}'/>"
        password: (name)->
            "<input type='password' name='#{name}' value='#{value}'/>"
        textarea:(name, value='')->
            "<textarea name='#{name}'>#{value}</textarea>"
        label:(name,label)->
            "<label for='#{name}'>#{label}</label>"
    constructor: (model) ->
        console.log "run contruct"
        @model=model
        @config={}
        (@config[field]=conf.form if conf.form?) for field, conf of model.schema.tree
    create:(data=null)->
        ret='';
        for name of @config
            console.log name
            ret+=
                Form.format.struct(
                    (Form.format.label name, (@config[name].label ? name))+
                    (Form.format[(@config[name].type ? 'text')] name)
                )
         ret

module.exports=Form
#module.exports = (options)->    
#    (req, res, next) ->
#        req.flash = _flash
#        res.locals.flash = _messages.bind req
#        next()
#
#_flash=(type, msg)->
#    throw Error 'req.flash() requires sessions' if !this.session?
#    msgs = this.session.flash = this.session.flash || {}
#    if (type && msg) 
#        return (msgs[type] = msgs[type] || []).push msg
#    else if (type)
#        arr = msgs[type]
#        delete msgs[type]
#        return arr || []
#    else
#        this.session.flash = {}
#        return msgs
#
#_messages = (type) ->
#    resp=""
#    msgs = this.session.flash
#    if !type?
#        ((type, content)->
#            resp+="<p class='#{type}'>#{message}</p>" for message in content
#        )(type,content) for type, content of msgs
#        this.session.flash = {}
#    else
#        arr = msgs[type]
#        delete msgs[type]
#        resp+="<p class='#{type}'>#{message}</p>" for message of arr
#
#    resp