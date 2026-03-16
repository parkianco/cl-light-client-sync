(asdf:defsystem #:cl-light-client-sync
  :depends-on (#:alexandria #:bordeaux-threads)
  :components ((:module "src"
                :components ((:file "package")
                             (:file "cl-light-client-sync" :depends-on ("package"))))))