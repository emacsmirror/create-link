;;; create-link-test.el --- Tests for create-link

(require 'ert)
(require 'create-link)

;;; Code:

(ert-deftest create-link-make-format-buffer-test ()
  "Each buffer can make format."
  ;; eww
  (eww "google.com")
  (should (string-match-p
           (format "<a href='.*google.com.*'></a>") ;; TODO: eww can't generate title when testing.
           (create-link-make-format)))

  ;; w3m
  (w3m-goto-url "google.com")
  (should (string-match-p
           (format "<a href='.*google.com.*'>Google</a>")
           (create-link-make-format)))

  ;; file
  (let ((buffer "buffer")
        (file "file"))
    (switch-to-buffer buffer)
    (write-file file)
    (should (string-match-p
             (format "<a href='.*/" file "'>" buffer "</a>")
             (create-link-make-format)))
    (delete-file file)))

(ert-deftest create-link-make-format-context-test ()
  "Each context can make format."
  (let ((buffer "buffer")
        (file "file")
        (content "content"))
    (switch-to-buffer buffer)
    (insert content)
    (beginning-of-buffer)
    (mark-word)
    (write-file file)

    (should (string-match-p
             (format "<a href='.*/" file "'>" content "</a>")
             (create-link-make-format)))
    (delete-file file)))

(provide 'create-link-test)

;;; create-link-test.el ends here
