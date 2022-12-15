package org.docbook.schemas.docbook;

// My attempts to build this class, and its sister class Publishers, with the
// gradle buildConfig plugin were an abject failure. I could not work out
// how to thread the needle of generating the sources, the classes, the
// javadoc and the jars. So I authored them by hand and I'll have to write
// some tests to make sure the testing version is correct.

public final class DocBook {
  public static final String[] VERSIONS = {"4.5", "5.0", "5.1", "5.2", "5.2CR4"};

  public static final String DOCBOOK_CATALOG_PATH = "/org/docbook/schemas/docbook/catalog.xml";

  public static final String DOCBOOK_4_5_RNG_PATH = "/org/docbook/schemas/docbook/4.5/rng/docbook.rng";

  public static final String DOCBOOK_4_5_RNC_PATH = "/org/docbook/schemas/docbook/4.5/rng/docbook.rnc";

  public static final String DOCBOOK_4_5_XSD_PATH = "/org/docbook/schemas/docbook/4.5/xsd/docbook.xsd";

  public static final String DOCBOOK_4_5_DTD_PATH = "/org/docbook/schemas/docbook/4.5/dtd/docbookx.dtd";

  public static final String DOCBOOK_5_0_DTD_PATH = "/org/docbook/schemas/docbook/5.0/dtd/docbook.dtd";

  public static final String DOCBOOK_5_0_RNG_PATH = "/org/docbook/schemas/docbook/5.0/rng/docbook.rng";

  public static final String DOCBOOK_5_0_RNC_PATH = "/org/docbook/schemas/docbook/5.0/rng/docbook.rnc";

  public static final String DOCBOOK_5_0_XSD_PATH = "/org/docbook/schemas/docbook/5.0/xsd/docbook.xsd";

  public static final String DOCBOOK_5_0_SCH_PATH = "/org/docbook/schemas/docbook/5.0/sch/docbook.sch";

  public static final String DOCBOOK_5_1_RNG_PATH = "/org/docbook/schemas/docbook/5.1/rng/docbook.rng";

  public static final String DOCBOOK_5_1_RNC_PATH = "/org/docbook/schemas/docbook/5.1/rng/docbook.rnc";

  public static final String DOCBOOK_5_1_SCH_PATH = "/org/docbook/schemas/docbook/5.1/sch/docbook.sch";

  public static final String DOCBOOK_5_2_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbook.rng";

  public static final String DOCBOOK_5_2_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbook.rnc";

  public static final String DOCBOOK_5_2_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/docbook.sch";

  public static final String DOCBOOK_5_2b10_SNAPSHOT_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbook.rng";

  public static final String DOCBOOK_5_2b10_SNAPSHOT_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbook.rnc";

  public static final String DOCBOOK_5_2b10_SNAPSHOT_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/docbook.sch";

  public static final String DOCBOOK_ITS_5_0_DTD_PATH = "/org/docbook/schemas/docbook/5.0/dtd/dbits.dtd";

  public static final String DOCBOOK_ITS_5_0_RNG_PATH = "/org/docbook/schemas/docbook/5.0/rng/dbits.rng";

  public static final String DOCBOOK_ITS_5_0_RNC_PATH = "/org/docbook/schemas/docbook/5.0/rng/dbits.rnc";

  public static final String DOCBOOK_ITS_5_1_RNG_PATH = "/org/docbook/schemas/docbook/5.1/rng/dbits.rng";

  public static final String DOCBOOK_ITS_5_1_RNC_PATH = "/org/docbook/schemas/docbook/5.1/rng/dbits.rnc";

  public static final String DOCBOOK_ITS_5_1_SCH_PATH = "/org/docbook/schemas/docbook/5.1/sch/dbits.sch";

  public static final String DOCBOOK_ITS_5_2_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/dbits.rng";

  public static final String DOCBOOK_ITS_5_2_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/dbits.rnc";

  public static final String DOCBOOK_ITS_5_2_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/dbits.sch";

  public static final String DOCBOOK_ITS_5_2b10_SNAPSHOT_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/dbits.rng";

  public static final String DOCBOOK_ITS_5_2b10_SNAPSHOT_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/dbits.rnc";

  public static final String DOCBOOK_ITS_5_2b10_SNAPSHOT_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/dbits.sch";

  public static final String DOCBOOK_XI_5_0_RNG_PATH = "/org/docbook/schemas/docbook/5.0/rng/docbookxi.rng";

  public static final String DOCBOOK_XI_5_0_RNC_PATH = "/org/docbook/schemas/docbook/5.0/rng/docbookxi.rnc";

  public static final String DOCBOOK_XI_5_1_RNG_PATH = "/org/docbook/schemas/docbook/5.1/rng/docbookxi.rng";

  public static final String DOCBOOK_XI_5_1_RNC_PATH = "/org/docbook/schemas/docbook/5.1/rng/docbookxi.rnc";

  public static final String DOCBOOK_XI_5_1_SCH_PATH = "/org/docbook/schemas/docbook/5.1/sch/docbookxi.sch";

  public static final String DOCBOOK_XI_5_2_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbookxi.rng";

  public static final String DOCBOOK_XI_5_2_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbookxi.rnc";

  public static final String DOCBOOK_XI_5_2_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/docbookxi.sch";

  public static final String DOCBOOK_XI_5_2b10_SNAPSHOT_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbookxi.rng";

  public static final String DOCBOOK_XI_5_2b10_SNAPSHOT_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/docbookxi.rnc";

  public static final String DOCBOOK_XI_5_2b10_SNAPSHOT_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/docbookxi.sch";

  public static final String DOCBOOK_ASSEMBLY_5_1_RNG_PATH = "/org/docbook/schemas/docbook/5.1/rng/assembly.rng";

  public static final String DOCBOOK_ASSEMBLY_5_1_RNC_PATH = "/org/docbook/schemas/docbook/5.1/rng/assembly.rnc";

  public static final String DOCBOOK_ASSEMBLY_5_1_SCH_PATH = "/org/docbook/schemas/docbook/5.1/sch/assembly.sch";

  public static final String DOCBOOK_ASSEMBLY_5_2_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/assembly.rng";

  public static final String DOCBOOK_ASSEMBLY_5_2_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/assembly.rnc";

  public static final String DOCBOOK_ASSEMBLY_5_2_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/assembly.sch";

  public static final String DOCBOOK_ASSEMBLY_5_2b10_SNAPSHOT_RNG_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/assembly.rng";

  public static final String DOCBOOK_ASSEMBLY_5_2b10_SNAPSHOT_RNC_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/rng/assembly.rnc";

  public static final String DOCBOOK_ASSEMBLY_5_2b10_SNAPSHOT_SCH_PATH = "/org/docbook/schemas/docbook/5.2b10-SNAPSHOT/sch/assembly.sch";

  private DocBook() {
  }
}
