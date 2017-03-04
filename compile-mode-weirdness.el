(defface face-frame
  '((t :foreground "white" :background "black" :weight bold)) "frames out for a failing test")

(defface face-wrong
  '((t :foreground "white" :background "darkred" :weight bold)) "highlight incorrect output in red")

(defface face-expected
  '((t :foreground "white" :background "darkgreen" :weight bold)) "show expected output in green")

(defconst error-regexp-alist
  '(("^Received\n\\(\\(.\\|\n\\)+?\\)\nExpected\n\\(\\(.\\|\n\\)+?\\)\n\\(.*\\):\\([[:digit:]]+\\)\n--$"
     5 6 nil nil nil (0 'face-frame) (1 'face-wrong) (3 'face-expected))))

(define-derived-mode weird-compilation-mode compilation-mode "Fixture Compilation"
  (set (make-local-variable 'compilation-error-regexp-alist)
       error-regexp-alist))

(defun demonstrate-weirdness ()
  (interactive)
  (with-current-buffer (get-buffer-create "*weird-regexp-matching-issue*")
    (compilation-start "./fixture.sh" 'weird-compilation-mode (lambda (m) (buffer-name)))
    ))
