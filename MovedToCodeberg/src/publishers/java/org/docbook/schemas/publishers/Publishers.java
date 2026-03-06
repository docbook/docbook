package org.docbook.schemas.publishers;

// My attempts to build this class, and its sister class DocBook, with the
// gradle buildConfig plugin were an abject failure. I could not work out
// how to thread the needle of generating the sources, the classes, the
// javadoc and the jars. So I authored them by hand and I'll have to write
// some tests to make sure the testing version is correct.

public final class Publishers {
  public static final String[] VERSIONS = {"1.0", "5.2"};

  public static final String PUBLISHERS_CATALOG_PATH = "/org/docbook/schemas/publishers/catalog.xml";

  public static final String PUBLISHERS_1_0_DTD_PATH = "/org/docbook/schemas/docbook/1.0/dtd/publishers.dtd";

  public static final String PUBLISHERS_1_0_RNG_PATH = "/org/docbook/schemas/docbook/1.0/rng/publishers.rng";

  public static final String PUBLISHERS_1_0_RNC_PATH = "/org/docbook/schemas/docbook/1.0/rng/publishers.rnc";

  public static final String PUBLISHERS_1_0_XSD_PATH = "/org/docbook/schemas/docbook/1.0/xsd/publishers.xsd";

  public static final String PUBLISHERS_1_0_SCH_PATH = "/org/docbook/schemas/docbook/1.0/sch/publishers.sch";

  public static final String PUBLISHERS_5_2_RNG_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/rng/publishers.rng";

  public static final String PUBLISHERS_5_2_RNC_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/rng/publishers.rnc";

  public static final String PUBLISHERS_5_2_SCH_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/sch/publishers.sch";

  public static final String PUBLISHERS_5_2b10_SNAPSHOT_RNG_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/rng/publishers.rng";

  public static final String PUBLISHERS_5_2b10_SNAPSHOT_RNC_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/rng/publishers.rnc";

  public static final String PUBLISHERS_5_2b10_SNAPSHOT_SCH_PATH = "/org/docbook/schemas/publishers/5.2b10-SNAPSHOT/sch/publishers.sch";

  private Publishers() {
  }
}
