artifacts builderVersion: "1.1", {

  group "com.sap.bds.ats-altiscale", {

    artifact "hadoop-lzo", {
      file "$gendir/src/hadoop-lzo-artifacts/hadoop-lzo-${buildVersion}-sap.jar", extension: "jar"
    }
    artifact "hadoop-lzo-libgplcompression", {
      file "$gendir/src/hadoop-lzo-artifacts/hadoop-lzo-libgplcompression-${buildVersion}-sap.tar.gz"
    }
  }
}
