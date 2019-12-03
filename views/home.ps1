div -class menu {
    h3 { "Hello " + $data.FullName }
    span 'What do you want to do'
    ul {
        li { a -href "/ad-create" { 'Create NIL AD User' }}
        li { a -href "/test" { 'Do Test' } }
    }
}
