||| Sets and display version of Idris.
module Idris.Version

import YafflePaths

||| Semantic versioning with optional tag
||| See [semver](https://semver.org/) for proper definition of semantic versioning
public export
record Version where
  constructor MkVersion
  ||| Semantic version
  ||| Should follow the (major, minor, patch) convention
  semVer : (Nat, Nat, Nat)
  ||| Optional tag
  ||| Usually contains git sha1 of this software's build in between releases
  versionTag : Maybe String

export
version : Version
version with (yversion)
  | (s,"") = MkVersion s Nothing
  | (s,t) = MkVersion s (Just t)

export
showVersion : Bool -> Version -> String
showVersion tag (MkVersion (maj,min,patch) versionTag) =
  concat (intersperse "." (map show [ maj, min, patch])) ++
         if tag then showTag else ""
  where
    showTag : String
    showTag = case versionTag of
                Nothing => ""
                Just tag => "-" ++ tag
