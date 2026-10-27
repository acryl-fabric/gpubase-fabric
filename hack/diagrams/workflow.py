#!/usr/bin/env python3
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Generates docs/images/workflow.svg. Run from the repository root: python3 hack/diagrams/workflow.py
from xml.sax.saxutils import escape as e
W,H=1280,560
o=[]
def rect(x,y,w,h,fill,stroke="none",rx=10,dash=None,sw=1.5):
    d=f' stroke-dasharray="{dash}"' if dash else ''
    o.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" fill="{fill}" stroke="{stroke}" stroke-width="{sw}"{d}/>')
def text(x,y,s,size=14,fill="#1b2433",weight="normal",anchor="middle"):
    o.append(f'<text x="{x}" y="{y}" font-size="{size}" fill="{fill}" font-weight="{weight}" text-anchor="{anchor}">{e(s)}</text>')
def arrow(x1,y1,x2,y2,c="#4a5568",dash=None):
    d=f' stroke-dasharray="{dash}"' if dash else ''
    o.append(f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{c}" stroke-width="2"{d} marker-end="url(#ar)"/>')
def step(x,y,w,h,t1,t2,fill="#ffffff",stroke="#c3cad8",c1="#14213d"):
    rect(x,y,w,h,fill,stroke,rx=8,sw=1.2); text(x+w/2,y+h/2-3,t1,13.5,c1,"bold"); text(x+w/2,y+h/2+15,t2,11.5,"#5b6474")
o.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" font-family="Inter, Segoe UI, Helvetica, Arial, sans-serif">')
o.append('<defs><marker id="ar" markerWidth="10" markerHeight="10" refX="8" refY="5" orient="auto"><path d="M0,0 L10,5 L0,10 z" fill="#4a5568"/></marker></defs>')
rect(0,0,W,H,"#ffffff",rx=16)
text(W/2,40,"Development & Validation Pipeline",24,"#14213d","bold")
text(W/2,64,"Public Core on GitHub · Extension and testbed CD on ACRYL internal GitLab",13,"#5b6474")
# GitHub lane
rect(40,84,W-80,200,"#eef3ff","#2B59C3",sw=2)
text(60,108,"GitHub  ·  acryl-fabric/gpubase-fabric  (public Core, MPL-2.0, GitHub-hosted runners only)",14,"#2B59C3","bold","start")
xs=[60,250,440,630,820,1010]; w=170; y=126; h=60
labels=[("Pull request","feature/{org}/{topic}"),("CI checks","ci · dco · gitleaks"),("1st review","LLM agent (advisory)"),("2nd review","CODEOWNERS (org teams)"),("Merge to main","branch protection"),("Publish","GHCR images · OCI chart")]
for i,(a,b) in enumerate(labels):
    step(xs[i],y,w,h,a,b, fill="#14213d" if i==4 else "#ffffff", stroke="#14213d" if i==4 else "#c3cad8", c1="#ffffff" if i==4 else "#14213d")
    if i==4: o[-1]=o[-1].replace('fill="#5b6474"','fill="#c9d3ea"')
    if i<5: arrow(xs[i]+w,y+h/2,xs[i+1]-4,y+h/2)
text(60,222,"Contributors: ACRYL · Yonsei · SKKU · Ajou · MangoBoost  —  commits signed off (DCO) with institutional e-mail",12.5,"#4a5568","normal","start")
text(60,244,"Images: ghcr.io/acryl-fabric/gpubase-fabric/<component>   ·   Chart: oci://ghcr.io/acryl-fabric/charts/gpubase-fabric",12.5,"#4a5568","normal","start")
text(60,266,"Release: tag v* → versioned images + Helm umbrella chart",12.5,"#4a5568","normal","start")
# GitLab lane
gy=330
rect(40,gy,W-80,180,"#f7f8fb","#9aa3b5",dash="7 5")
text(60,gy+24,"ACRYL internal GitLab (private)",14,"#4a5568","bold","start"); text(W-100,gy+24,"JONATHAN GPUBASE Extension + testbed CD — planned",12.5,"#8a93a3","normal","end")
gl=[("Extension repo","Core as Git submodule"),("Detect main change","GitHub → GitLab sync"),("Deploy to testbed","RoCEv2 GPU cluster"),("Benchmark","throughput · latency"),("Report back","commit comment on GitHub")]
gx=[60,290,520,750,980]; gw=200; gyy=gy+44
for i,(a,b) in enumerate(gl):
    step(gx[i],gyy,gw,60,a,b)
    if i<4: arrow(gx[i]+gw,gyy+30,gx[i+1]-4,gyy+30)
text(60,gy+140,"Dependency is one-way: Extension → Core (via api/). Core never references Extension code.",12.5,"#4a5568","normal","start")
text(60,gy+160,"Testbed addresses, credentials and customer data stay in GitLab and never enter the public repository.",12.5,"#4a5568","normal","start")
# cross arrows
o.append(f'<path d="M905,186 V307 H390 V{gyy-2}" fill="none" stroke="#2B59C3" stroke-width="2" stroke-dasharray="6 4" marker-end="url(#ar)"/>')
text(650,301,"main updated → sync",12,"#2B59C3","bold")
o.append(f'<path d="M1180,{gyy+30} C1228,{gyy+30} 1228,240 1150,190" fill="none" stroke="#2B59C3" stroke-width="2" stroke-dasharray="6 4" marker-end="url(#ar)"/>')
text(1196,300,"results",12,"#2B59C3","bold","end")
o.append('</svg>')
open("docs/images/workflow.svg","w").write("\n".join(o))
