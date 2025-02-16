;;extends

(html_tag 
(#set! conceal ""))

; ~/.config/nvim/after/queries/markdown/highlights.scm

; Main capture for highlighting
((inline) @mark_tag
  (#match? @mark_tag "<mark.*>.*</mark>")
  (#set! "priority" 120))
