Paperclip.interpolates :attachable_type do |attachment, style|
  attachment.instance.attachable_type.blank? ? 'imported_docs' : attachment.instance.attachable_type.tableize
end

Paperclip.interpolates :attachable_id do |attachment, style|
  attachment.instance.attachable_id.blank? ? attachment.instance.id : attachment.instance.attachable_id
end