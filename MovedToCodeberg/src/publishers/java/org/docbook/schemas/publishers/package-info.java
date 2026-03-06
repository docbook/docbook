/** The DocBook Publishers schemas.
 *
 * <p>This package contains the DocBook Publishers schema files. They can
 * be accessed by unzipping the jar file or, in some environments,
 * simply using <code>classpath:</code> URIs.</p>
 *
 * <p>The {@link org.docbook.schemas.publishers.Publishers} class defines a number of
 * constants. To be perfectly candid, the main reason the class exists
 * at all is to satisfy the requirements of the Maven publication process,
 * but if it's going to exists, we might as well make it (a little bit?)
 * useful.</p>
 *
 * <p>The <code>VERSIONS</code> array contains a list of the versions
 * of DocBook Publishers in this release. For example,
 * "1.0" and "5.2". For test releases, the actual test
 * release version will also be in the list.</p>
 *
 * <p>The <code>PUBLISHERS_CATALOG_PATH</code> contains the relative location of
 * the catalog file for these schemas within this archive.</p>
 *
 * <p>Then there are constants for each primary schema. For example,
 * <code>PUBLISHERS_1_0_DTD_PATH</code> and
 * <code>PUBLISHERS_5_2_RNG_PATH</code> contain the relative
 * locations of the DTD for Publishers 1.0 and the RELAX NG Schema for Publishers 5.2,
 * respectively.</p>
 */
package org.docbook.schemas.publishers;
