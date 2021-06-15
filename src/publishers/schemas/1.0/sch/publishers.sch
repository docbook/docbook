<?xml version="1.0" encoding="utf-8"?>
<s:schema xmlns:s="http://purl.oclc.org/dsdl/schematron"
          xmlns:db="http://docbook.org/ns/docbook">
   <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
   <s:pattern name="Glossary 'firstterm' type constraint">
      <s:rule context="db:firstterm[@linkend]">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on firstterm must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Footnote reference type constraint">
      <s:rule context="db:footnoteref">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'footnote' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on footnoteref must point to a footnote.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary 'glossterm' type constraint">
      <s:rule context="db:glossterm[@linkend]">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on glossterm must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glosssary 'see' type constraint">
      <s:rule context="db:glosssee[@otherterm]">
         <s:assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glosssee must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary 'seealso' type constraint">
      <s:rule context="db:glossseealso[@otherterm]">
         <s:assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glossseealso must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary term definition constraint">
      <s:rule context="db:termdef">
         <s:assert test="count(db:firstterm) = 1">A termdef must contain exactly one firstterm</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Root must have version">
      <s:rule context="/db:title">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:subject">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:abstract">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:para">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:date">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:publisher">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:set">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:book">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:dedication">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:acknowledgements">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:colophon">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:appendix">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:chapter">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:part">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:preface">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:section">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:article">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:glossary">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:bibliography">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:index">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:toc">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:any">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:poetry">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:dialogue">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:drama">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Element exclusion">
      <s:rule context="db:caption">
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:task)">task must not occur among the children or descendants of caption</s:assert>
      </s:rule>
      <s:rule context="db:equation">
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of equation</s:assert>
      </s:rule>
      <s:rule context="db:example">
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of example</s:assert>
      </s:rule>
      <s:rule context="db:figure">
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of figure</s:assert>
      </s:rule>
      <s:rule context="db:table">
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:informaltable)">informaltable must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of table</s:assert>
      </s:rule>
      <s:rule context="db:footnote">
         <s:assert test="not(.//db:epigraph)">epigraph must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:footnote)">footnote must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:task)">task must not occur among the children or descendants of footnote</s:assert>
      </s:rule>
      <s:rule context="db:note">
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of note</s:assert>
      </s:rule>
      <s:rule context="db:sidebar">
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of sidebar</s:assert>
      </s:rule>
   </s:pattern>
</s:schema>