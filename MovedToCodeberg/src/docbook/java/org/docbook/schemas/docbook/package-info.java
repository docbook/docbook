/** The DocBook schemas.
 *
 * <p>This package contains the DocBook schema files. They can
 * be accessed by unzipping the jar file or, in some environments,
 * simply using <code>classpath:</code> URIs.</p>
 *
 * <p>The {@link org.docbook.schemas.docbook.DocBook} class defines a number of
 * constants. To be perfectly candid, the main reason the class exists
 * at all is to satisfy the requirements of the Maven publication process,
 * but if it's going to exists, we might as well make it (a little bit?)
 * useful.</p>
 *
 * <p>The <code>VERSIONS</code> array contains a list of the versions
 * of DocBook in this release. For example,
 * "4.5", "5.0", "5.1", and "5.2". For test releases, the actual test
 * release version will also be in the list.</p>
 *
 * <p>The <code>DOCBOOK_CATALOG_PATH</code> contains the relative location of
 * the catalog file for these schemas within this archive.</p>
 *
 * <p>Then there are constants for each primary schema. For example,
 * <code>DOCBOOK_5_2_RNG_PATH</code> and
 * <code>DOCBOOK_ASSEMBLY_5_2_RNG_PATH</code> contain the relative
 * locations of the RELAX NG Schemas for DocBook and DocBook Assembly,
 * respectively.</p>
 */
package org.docbook.schemas.docbook;
