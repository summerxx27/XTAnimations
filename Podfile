
platform :ios, '11.0'

def public_pods

  pod 'pop'
  pod 'SnapKit'
  pod 'Masonry'

  import_relative_in 'Components' do
    pod 'ModuleA'
  end

end

target 'XTAnimations' do
  project 'XTAnimations'
  public_pods
end

install!('cocoapods',
         :deterministic_uuids => false,
         :generate_multiple_pod_projects => true,
         :incremental_installation => true,
         :warn_for_unused_master_specs_repo => false)

